require 'spec_helper'

describe UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET new" do
    it "assigns a new User object" do
      User.stub(:new) { mock_user }
      get :new
      assigns(:user).should eq(mock_user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before :each do
        User.stub(:new).with('these' => 'params') {mock_user(:save => true)}
      end

      it "assigns a newly created user as @user" do
        post :create, :user => {'these' => 'params'}
        assigns(:user).should be(mock_user)
      end

      it "redirects to next_url" do
        session[:next_url] = '/finish_line'
        post :create, :user => {'these' => 'params'}
        response.should redirect_to('/finish_line')
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
