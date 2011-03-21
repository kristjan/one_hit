require 'spec_helper'

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

    describe "when you're logged in and have authed before" do
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
  end

  describe "GET new" do
    it "assigns a new User object" do
      User.stub(:new) { mock_user }
      get :new
      assigns(:user).should eq(mock_user)
    end

    it "loads your pending sites" do
      waiting, twiddling = new_site, new_site
      controller.stub(:pending_sites) {[waiting.url, twiddling.url]}
      Site.stub(:fetch).with(waiting.url) { waiting }
      Site.stub(:fetch).with(twiddling.url) { twiddling }
      get :new
      assigns(:pending_sites).should eq([waiting, twiddling])
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
end
