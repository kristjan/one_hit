require 'spec_helper'
include AuthorizationTestHelper

describe SitesController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_site(stubs={})
    @mock_site ||= mock_model(Site, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all sites as @sites" do
      Site.stub(:all) { [mock_site] }
      get :index
      assigns(:sites).should eq([mock_site])
    end
  end

  describe "GET show" do
    it "assigns the requested site as @site" do
      Site.stub(:fetch).with("url") { mock_site }
      get :show, :id => "url"
      assigns(:site).should be(mock_site)
    end

    it "redirects nonexistent sites to /404" do
      Site.stub(:fetch).with("nonexistent") { nil }
      get :show, :id => "nonexistent"
      response.should redirect_to '/404'
    end
  end

  describe "GET random" do
    it "redirects to a random Site" do
      Site.should_receive(:random).and_return(mock_site)
      get :random
      response.should redirect_to(site_path(mock_site))
    end

    it "sends you home if there are no sites" do
      Site.should_receive(:random).and_return(nil)
      get :random
      response.should redirect_to(root_path)
    end
  end

  describe "GET new" do
    it "assigns a new site as @site" do
      Site.stub(:new) { mock_site }
      get :new
      assigns(:site).should be(mock_site)
    end
  end

  describe "GET edit" do
    before :each do
      Site.stub(:fetch).with("url") { mock_site }
    end

    it "assigns the requested site as @site" do
      get :edit, :id => "url"
      assigns(:site).should be(mock_site)
    end

    describe "when there is a creator" do
      before :each do
        mock_site.stub(:creator).and_return(mock_user)
      end

      it "admits the creator" do
        log_in_as(mock_site.creator)
        get :edit, :id => "url"
        response.should be_success
      end

      it "denies non-creators" do
        log_in_as_guest
        get :edit, :id => "url"
        response.should be_redirect
      end
    end

    describe "when there is no creator" do
      before :each do
        mock_site.stub(:creator).and_return(nil)
      end

      it "allows anyone" do
        log_in_as_guest
        get :edit, :id => "url"
        response.should be_success
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created site as @site" do
        Site.stub(:new).with({'these' => 'params'}) { mock_site(:save => true) }
        post :create, :site => {'these' => 'params'}
        assigns(:site).should be(mock_site)
      end

      describe "when you're logged in" do
        before :each do
          controller.stub(:viewer) { mock_user }
        end

        it "sets the site's creator" do
          Site.stub(:new) { mock_site }
          mock_site.should_receive(:creator=).with(mock_user)
          post :create
        end

        it "redirects to the quips index" do
          Site.stub(:new) { mock_site(:save => true, :creator => mock_user) }
          post :create, :site => {}
          response.should redirect_to(site_quips_path(mock_site))
        end
      end

      describe "when you're not logged in" do
        before :each do
          controller.stub(:viewer) { nil }
          Site.stub(:new) { mock_site(:save => true, :creator => nil) }
        end

        it "saves the site in your pending list" do
          Site.stub(:new) { mock_site(:save => true) }
          post :create, :site => {'these' => 'params'}
          controller.session[:pending_sites].should include(mock_site.url)
        end

        it "sets a :next_url" do
          post :create, :site => {}
          controller.session[:next_url].should == site_quips_path(mock_site)
        end

        it "redirects to the user creation form" do
          post :create, :site => {}
          response.should redirect_to(new_user_path)
        end
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved site as @site" do
        Site.stub(:new).with({'these' => 'params'}) { mock_site(:save => false) }
        post :create, :site => {'these' => 'params'}
        assigns(:site).should be(mock_site)
      end

      it "re-renders the 'new' template" do
        Site.stub(:new) { mock_site(:save => false) }
        post :create, :site => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before :each do
        Site.stub(:fetch).and_return(mock_site(:update_attributes => true))
      end

      it "assigns the requested site as @site" do
        put :update, :id => "url"
        assigns(:site).should be(mock_site)
      end

      describe "when you are the creator" do
        before :each do
          log_in_as mock_site.creator
        end

        it "updates the requested site" do
          mock_site.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "url", :site => {'these' => 'params'}
        end

        it "redirects to the site" do
          put :update, :id => "url"
          response.should redirect_to(site_path(mock_site))
        end
      end

      describe "when you are not the creator" do
        before :each do
          log_in_as_guest
        end

        it "does not update the requested site" do
          mock_site.should_not_receive(:update_attributes)
          put :update, :id => "url"
        end

        it "redirects to the site" do
          put :update, :id => "url"
          response.should redirect_to(site_path(mock_site))
        end
      end

      describe "when there is no creator" do
        before :each do
          mock_site.stub(:creator).and_return(nil)
          log_in_as_guest
        end

        it "updates the requested site" do
          mock_site.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "url", :site => {'these' => 'params'}
        end

        it "redirects to the site" do
          put :update, :id => "url"
          response.should redirect_to(site_path(mock_site))
        end
      end
    end

    describe "with invalid params" do
      before :each do
        Site.stub(:fetch).and_return(mock_site(:update_attributes => false))
      end

      describe "when you are the creator" do
        before :each do
          log_in_as mock_site.creator
        end

        it "assigns the site as @site" do
          put :update, :id => "url"
          assigns(:site).should be(mock_site)
        end

        it "re-renders the 'edit' template" do
          put :update, :id => "url"
          response.should render_template("edit")
        end
      end

      describe "when you are not the creator" do
        before :each do
          log_in_as_guest
        end

        it "redirects to the site" do
          put :update, :id => "url"
          response.should redirect_to(site_path(mock_site))
        end
      end

      describe "when there is no creator" do
        before :each do
          mock_site.stub(:creator).and_return(nil)
          log_in_as_guest
        end

        it "assigns the site as @site" do
          put :update, :id => "url"
          assigns(:site).should be(mock_site)
        end

        it "re-renders the 'edit' template" do
          put :update, :id => "url"
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    describe "when you are the creator" do
      before :each do
        log_in_as mock_site.creator
      end

      it "destroys the requested site" do
        Site.stub(:fetch).with("url") { mock_site }
        mock_site.should_receive(:destroy)
        delete :destroy, :id => "url"
      end

      it "redirects to the sites list" do
        Site.stub(:fetch) { mock_site }
        delete :destroy, :id => "url"
        response.should redirect_to(sites_path)
      end
    end

    describe "when you are not the creator" do
      before :each do
        log_in_as_guest
      end

      it "does not destroy the requested site" do
        Site.stub(:fetch).with("url") { mock_site }
        mock_site.should_not_receive(:destroy)
        delete :destroy, :id => "url"
      end

      it "redirects to the site" do
        Site.stub(:fetch) { mock_site }
        delete :destroy, :id => "url"
        response.should redirect_to(site_path(mock_site))
      end
    end

    describe "when there is no creator" do
      before :each do
        mock_site(:creator => nil)
        log_in_as_guest
      end

      it "destroys the requested site" do
        Site.stub(:fetch).with("url") { mock_site }
        mock_site.should_receive(:destroy)
        delete :destroy, :id => "url"
      end

      it "redirects to the sites list" do
        Site.stub(:fetch) { mock_site }
        delete :destroy, :id => "url"
        response.should redirect_to(sites_path)
      end
    end
  end
end
