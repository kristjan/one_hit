require 'spec_helper'

describe SitesController do

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
    it "assigns the requested site as @site" do
      Site.stub(:fetch).with("url") { mock_site }
      get :edit, :id => "url"
      assigns(:site).should be(mock_site)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created site as @site" do
        Site.stub(:new).with({'these' => 'params'}) { mock_site(:save => true) }
        post :create, :site => {'these' => 'params'}
        assigns(:site).should be(mock_site)
      end

      it "redirects to the quips index" do
        Site.stub(:new) { mock_site(:save => true) }
        post :create, :site => {}
        response.should redirect_to(site_quips_path(mock_site))
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
      it "updates the requested site" do
        Site.stub(:fetch).with("url") { mock_site }
        mock_site.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "url", :site => {'these' => 'params'}
      end

      it "assigns the requested site as @site" do
        Site.stub(:fetch) { mock_site(:update_attributes => true) }
        put :update, :id => "url"
        assigns(:site).should be(mock_site)
      end

      it "redirects to the site" do
        Site.stub(:fetch) { mock_site(:update_attributes => true) }
        put :update, :id => "url"
        response.should redirect_to(site_path(mock_site))
      end
    end

    describe "with invalid params" do
      it "assigns the site as @site" do
        Site.stub(:fetch) { mock_site(:update_attributes => false) }
        put :update, :id => "url"
        assigns(:site).should be(mock_site)
      end

      it "re-renders the 'edit' template" do
        Site.stub(:fetch) { mock_site(:update_attributes => false) }
        put :update, :id => "url"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
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
