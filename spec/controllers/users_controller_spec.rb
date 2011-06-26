require 'spec_helper'
include AuthorizationTestHelper

describe UsersController do

  def mock_auth(stubs={})
    @mock_auth ||= mock_model(Authorization, stubs).as_null_object
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET authorize" do
    before :each do
      @auth_info = {
        'provider' => 'giver',
        'uid' => 'jonas',
        'credentials' => {
          'token' => Faker::Lorem.words.join,
          'secret' => Faker::Lorem.words.join
        },
        'user_info' => {
          'name' => 'Jonas of Giville'
        }
      }
      request.env["rack.auth"] = @auth_info
    end

    describe "when you're logged in" do
      before :each do
        controller.stub(:viewer).and_return(mock_user)
      end

      describe "and have authed before" do
        before :each do
          @auth = mock_auth(:user => mock_user)
          Authorization.stub(:find_by_hash).and_return(@auth)
        end

        it "redirects you along" do
          next_url = Faker::Internet.http_url
          session[:next_url] = next_url
          get :authorize
          response.should redirect_to(next_url)
        end
      end

      describe "and haven't authed before" do
        before :each do
          Authorization.stub(:find_by_hash).and_return(nil)
        end

        it "attaches the auth to the current user" do
          Authorization.should_receive(:build).with(mock_user, @auth_info).
            and_return(mock_auth(:user => mock_user))
          get :authorize
        end

        it "redirects you along" do
          next_url = Faker::Internet.http_url
          session[:next_url] = next_url
          get :authorize
          response.should redirect_to(next_url)
        end
      end
    end

    describe "when you're not logged in" do
      describe "and have authed before" do
        before :each do
          @auth = mock_auth(:user => mock_user)
          Authorization.stub(:find_by_hash).and_return(@auth)
        end

        it "logs you in" do
          get :authorize
          controller.send(:viewer).should == mock_user
        end

        it "redirects you along" do
          next_url = Faker::Internet.http_url
          session[:next_url] = next_url
          get :authorize
          response.should redirect_to(next_url)
        end
      end

      describe "and haven't authed before" do
        before :each do
          Authorization.stub(:find_by_hash).and_return(nil)
        end

        it "logs in the new user" do
          Authorization.should_receive(:build).with(nil, @auth_info).
            and_return(mock_auth(:user => mock_user))
          get :authorize
          controller.send(:viewer).should == mock_user
        end

        it "redirects you along" do
          next_url = Faker::Internet.http_url
          session[:next_url] = next_url
          get :authorize
          response.should redirect_to(next_url)
        end
      end
    end

    context "when you have pending sites" do
      it "grants them" do
        Authorization.stub(:find_or_build).
          and_return(mock('Authorization', :user => mock_user))
        mock_user.should_receive(:claim_sites).with(['waiting', 'twiddling'])
        controller.stub(:pending_sites) { ['waiting', 'twiddling']}
        get :authorize, :user => {'these' => 'params'}
      end
    end
  end

  describe "GET edit" do
    before :each do
      User.stub(:find_by_id).and_return(mock_user)
    end

    it "assigns the requested user as @user" do
      get :edit, :id => mock_user.id
      assigns(:user).should be(mock_user)
    end

    describe "when you are the user" do
      before :each do
        log_in_as mock_user
      end

      it "renders the edit form" do
        get :edit, :id => mock_user.id
        response.should render_template("edit")
      end
    end

    describe "when you are not the user" do
      before :each do
        log_in_as_guest
      end

      it "redirects you to the user profile" do
        get :edit, :id => mock_user.id
        response.should redirect_to(user_path(mock_user))
      end
    end
  end

  describe "GET new" do
    it "assigns a new User object" do
      User.stub(:new) { mock_user }
      get :new
      assigns(:user).should eq(mock_user)
    end

    context "when there's a next_url" do
      it "stores the next_url in your session" do
        url = Faker::Internet.http_url
        get :new, :next_url => url
        session[:next_url].should == url
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before :each do
        User.stub(:new).with('these' => 'params') {mock_user(:save => true)}
      end

      describe "when you're a new user" do
        it "assigns a newly created user as @user" do
          post :create, :user => {'these' => 'params'}
          assigns(:user).should be(mock_user)
        end

        it "redirects to next_url" do
          session[:next_url] = '/finish_line'
          post :create, :user => {'these' => 'params'}
          response.should redirect_to('/finish_line')
        end

        it "logs you in" do
          post :create, :user => {'these' => 'params'}
          session[:viewer_id].should == mock_user.id
        end
      end

      describe "when you're a returning user with the right password" do
        before :each do
          User.stub(:find_by_login).
               with('email' => 'test@example.com',
                    'password' => 'god') { mock_user(:authenticated? => true) }
        end

        it "assigns your user object to @user" do
          post :create, :user => {:email => 'test@example.com',
                                  :password => 'god'}
          assigns(:user).should be(mock_user)
        end

        it "redirects to next_url" do
          session[:next_url] = '/finish_line'
          post :create, :user => {:email => 'test@example.com',
                                  :password => 'god'}
          response.should redirect_to('/finish_line')
        end

        it "logs you in" do
          post :create, :user => {:email => 'test@example.com',
                                  :password => 'god'}
          session[:viewer_id].should == mock_user.id
        end
      end

      describe "with you're a returning user with the wrong password" do
        before :each do
          User.stub(:find_by_login) {
            mock_user(:new_record? => true, :email => 'test@example.com')
          }
        end

        it "assigns a new user to @user" do
          post :create, :user => {'email' => 'test@example.com'}
          assigns(:user).should be(mock_user)
        end

        it "remembers the email address" do
          post :create, :user => {'email' => 'test@example.com'}
          assigns(:user).email.should ==  'test@example.com'
        end

        it "re-renders the 'new' template" do
          post :create, :user => {'email' => 'test@example.com'}
          response.should render_template("new")
        end
      end

      it "grants you your pending sites" do
        mock_user.should_receive(:claim_sites).with(['waiting', 'twiddling'])
        controller.stub(:pending_sites) { ['waiting', 'twiddling']}
        post :create, :user => {'these' => 'params'}
      end
    end

    describe "with invalid params" do
      before :each do
        User.stub(:new) {mock_user(:save => false)}
      end

      it "assigns a newly created but unsaved user as @user" do
        post :create, :user => {}
        assigns(:user).should be(mock_user)
      end

      it "re-renders the 'new' template" do
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      User.stub(:find_by_id).and_return(mock_user)
      get :show, :id => mock_user.id
      assigns(:user).should be(mock_user)
    end

    it "redirects nonexistent users to /404" do
      get :show, :id => -1
      response.should redirect_to '/404'
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before :each do
        User.stub(:find_by_id).and_return(mock_user(:update_attributes => true))
      end

      it "assigns the requested user as @user" do
        put :update, :id => "1"
        assigns(:user).should be(mock_user)
      end

      describe "when you are the user" do
        before :each do
          log_in_as mock_user
        end

        it "updates the requested user" do
          mock_user.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "1", :user => {'these' => 'params'}
        end

        it "redirects to the user" do
          put :update, :id => "1"
          response.should redirect_to(user_path(mock_user))
        end
      end

      describe "when you are not the user" do
        before :each do
          log_in_as_guest
        end

        it "does not update the requested user" do
          mock_user.should_not_receive(:update_attributes)
          put :update, :id => "1"
        end

        it "redirects to the user" do
          put :update, :id => "1"
          response.should redirect_to(user_path(mock_user))
        end
      end
    end

    describe "with invalid params" do
      before :each do
        User.stub(:find_by_id).and_return(mock_user(:update_attributes => false))
      end

      describe "when you are the user" do
        before :each do
          log_in_as mock_user
        end

        it "assigns the user as @user" do
          put :update, :id => "1"
          assigns(:user).should be(mock_user)
        end

        it "re-renders the 'edit' template" do
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end

      describe "when you are not the user" do
        before :each do
          log_in_as_guest
        end

        it "redirects to the user" do
          put :update, :id => "1"
          response.should redirect_to(user_path(mock_user))
        end
      end
    end
  end
end
