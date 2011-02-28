require 'spec_helper'

describe QuipsController do
  SITE_SLUG = "onehitwonders"

  def mock_quip(stubs={})
    stubs = stubs.reverse_merge(:site => mock_site)
    @mock_quip ||= mock_model(Quip, stubs).as_null_object
  end

  def mock_site(stubs={})
    slug = stubs[:slug] || SITE_SLUG
    stubs = stubs.reverse_merge(:to_param => slug)
    @mock_site ||= mock_model(Site, stubs).as_null_object
  end

  before(:each) do
    Site.stub(:find_by_slug).with(SITE_SLUG) {mock_site}
  end

  it "loads the containing site" do
    QuipsController._process_action_callbacks.find do |callback|
      callback.kind == :before && callback.filter == :load_site
    end.should be
  end

  it "redirects to root if the site doesn't exist" do
    Site.stub(:find_by_slug){nil}
    controller.should_receive(:redirect_to).
      with('http://test.host/', :notice => "That site doesn't exist")
    controller.send(:load_site)
  end

  describe "GET index" do
    it "assigns all quips as @quips" do
      Quip.stub(:all) {[mock_quip]}
      get :index, :site_id => SITE_SLUG
      assigns(:quips).should eq([mock_quip])
    end
  end

  describe "GET show" do
    it "assigns the requested quip as @quip" do
      Quip.stub(:find).with("37") {mock_quip}
      get :show, :id => "37", :site_id => SITE_SLUG
      assigns(:quip).should be(mock_quip)
    end
  end

  describe "GET new" do
    it "assigns a new quip as @quip" do
      Quip.stub(:new) {mock_quip}
      get :new, :site_id => SITE_SLUG
      assigns(:quip).should be(mock_quip)
    end
  end

  describe "GET edit" do
    it "assigns the requested quip as @quip" do
      Quip.stub(:find).with("37") {mock_quip}
      get :edit, :id => "37", :site_id => SITE_SLUG
      assigns(:quip).should be(mock_quip)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created quip as @quip" do
        Quip.stub(:new).with({'these' => 'params'}) {mock_quip(:save => true)}
        post :create, :quip => {'these' => 'params'}, :site_id => SITE_SLUG
        assigns(:quip).should be(mock_quip)
      end

      it "redirects to the created quip" do
        Quip.stub(:new) {mock_quip(:save => true)}
        post :create, :quip => {}, :site_id => SITE_SLUG
        response.should redirect_to(site_quip_url(SITE_SLUG, mock_quip))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quip as @quip" do
        Quip.stub(:new).with({'these' => 'params'}) {mock_quip(:save => false)}
        post :create, :quip => {'these' => 'params'}, :site_id => SITE_SLUG
        assigns(:quip).should be(mock_quip)
      end

      it "re-renders the 'new' template" do
        Quip.stub(:new) {mock_quip(:save => false)}
        post :create, :quip => {}, :site_id => SITE_SLUG
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quip" do
        Quip.stub(:find).with("37") {mock_quip}
        mock_quip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :quip => {'these' => 'params'},
                     :site_id => SITE_SLUG
      end

      it "assigns the requested quip as @quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => true)}
        put :update, :id => "1", :site_id => SITE_SLUG
        assigns(:quip).should be(mock_quip)
      end

      it "redirects to the quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => true)}
        put :update, :id => "1", :site_id => SITE_SLUG
        response.should redirect_to(site_quip_url(SITE_SLUG, mock_quip))
      end
    end

    describe "with invalid params" do
      it "assigns the quip as @quip" do
        Quip.stub(:find) {mock_quip(:update_attributes => false)}
        put :update, :id => "1", :site_id => SITE_SLUG
        assigns(:quip).should be(mock_quip)
      end

      it "re-renders the 'edit' template" do
        Quip.stub(:find) {mock_quip(:update_attributes => false)}
        put :update, :id => "1", :site_id => SITE_SLUG
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quip" do
      Quip.stub(:find).with("37") {mock_quip}
      mock_quip.should_receive(:destroy)
      delete :destroy, :id => "37", :site_id => SITE_SLUG
    end

    it "redirects to the quips list" do
      Quip.stub(:find) {mock_quip}
      delete :destroy, :id => "1", :site_id => SITE_SLUG
      response.should redirect_to(site_quips_url(SITE_SLUG))
    end
  end

end
