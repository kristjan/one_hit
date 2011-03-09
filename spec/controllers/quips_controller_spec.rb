require 'spec_helper'

describe QuipsController do
  SITE_URL = "onehitwonders"

  def mock_quip(stubs={})
    stubs = stubs.reverse_merge(:site => mock_site)
    @mock_quip ||= mock_model(Quip, stubs).as_null_object
  end

  def mock_site(stubs={})
    url = stubs[:url] || SITE_URL
    stubs = stubs.reverse_merge(:to_param => url)
    @mock_site ||= mock_model(Site, stubs).as_null_object
  end

  before(:each) do
    @site = mock_site
    Site.stub(:fetch).with(SITE_URL) {@site}
  end

  it "loads the containing site" do
    QuipsController._process_action_callbacks.find do |callback|
      callback.kind == :before && callback.filter == :load_site
    end.should be
  end

  it "redirects to root if the site doesn't exist" do
    Site.stub(:fetch){nil}
    controller.should_receive(:redirect_to).
      with(root_path, :notice => "That site doesn't exist")
    controller.send(:load_site)
  end

  describe "GET index" do
    it "assignes all quips as @quips" do
      @site.stub(:quips) {[mock_quip]}
      get :index, :site_id => SITE_URL
      assigns(:quips).should eq([mock_quip])
    end

    it "builds a new quip with the current site" do
      Quip.stub(:new) {mock_quip}
      get :index, :site_id => SITE_URL
      assigns(:quip).should eq(mock_quip)
      assigns(:quip).site.should eq(assigns(:site))
    end
  end

  describe "GET new" do
    it "redirects to the quips index" do
      get :new, :site_id => SITE_URL
      response.should redirect_to(site_quips_path(SITE_URL))
    end
  end

  describe "GET edit" do
    it "assigns the requested quip as @quip" do
      Quip.stub(:find).with("37") {mock_quip}
      get :edit, :id => "37", :site_id => SITE_URL
      assigns(:quip).should be(mock_quip)
    end

    it "redirects to the quips index" do
      Quip.stub(:find).with("37") {mock_quip}
      get :edit, :id => "37", :site_id => SITE_URL
      response.should redirect_to(site_quips_path(SITE_URL))
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created quip as @quip" do
        Quip.stub(:new) {mock_quip(:save => true)}
        post :create, :quip => {'these' => 'params'}, :site_id => SITE_URL
        assigns(:quip).should be(mock_quip)
      end

      it "infers the site" do
        Quip.should_receive(:new).
          with({'these' => 'params', 'site' => @site}) {mock_quip}
        post :create, :quip => {'these' => 'params'}, :site_id => SITE_URL
      end

      it "redirects to the index" do
        Quip.stub(:new) {mock_quip(:save => true)}
        post :create, :quip => {}, :site_id => SITE_URL
        response.should redirect_to(site_quips_path(SITE_URL))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quip as @quip" do
        Quip.stub(:new) {mock_quip(:save => false)}
        post :create, :quip => {}, :site_id => SITE_URL
        assigns(:quip).should be(mock_quip)
      end

      it "re-renders the 'index' template" do
        Quip.stub(:new) {mock_quip(:save => false)}
        post :create, :quip => {}, :site_id => SITE_URL
        response.should render_template("index")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quip" do
        Quip.stub(:find).with("37") {mock_quip}
        mock_quip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :quip => {'these' => 'params'},
                     :site_id => SITE_URL
      end

      it "assigns the requested quip as @quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => true)}
        put :update, :id => "1", :site_id => SITE_URL
        assigns(:quip).should be(mock_quip)
      end

      it "redirects to the quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => true)}
        put :update, :id => "1", :site_id => SITE_URL
        response.should redirect_to(site_quips_path(SITE_URL))
      end
    end

    describe "with invalid params" do
      it "assigns the quip as @quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => false)}
        put :update, :id => "1", :site_id => SITE_URL
        assigns(:quip).should be(mock_quip)
      end

      it "re-renders the 'index' template" do
        Quip.stub(:find) {mock_quip(:update_attributes => false)}
        put :update, :id => "1", :site_id => SITE_URL
        response.should render_template("index")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quip" do
      Quip.stub(:find).with("37") {mock_quip}
      mock_quip.should_receive(:destroy)
      delete :destroy, :id => "37", :site_id => SITE_URL
    end

    it "redirects to the quips list" do
      Quip.stub(:find) {mock_quip}
      delete :destroy, :id => "1", :site_id => SITE_URL
      response.should redirect_to(site_quips_path(SITE_URL))
    end
  end

end
