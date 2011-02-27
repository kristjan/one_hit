require "spec_helper"

describe SitesController do
  describe "routing" do

    it "is the root controller" do
      {:get => "/"}.should route_to(
        :controller => "sites", :action => "index")
    end

    it "recognizes and generates #index" do
      {:get => "/sites"}.should route_to(
        :controller => "sites", :action => "index")
    end

    it "recognizes and generates #new" do
      {:get => "/sites/new"}.should route_to(
        :controller => "sites", :action => "new")
    end

    it "recognizes and generates #show" do
      {:get => "/sites/onehitwonders"}.should route_to(
        :controller => "sites", :action => "show", :id => "onehitwonders")
    end

    it "recognizes and generates #edit" do
      {:get => "/sites/onehitwonders/edit"}.should route_to(
        :controller => "sites", :action => "edit", :id => "onehitwonders")
    end

    it "recognizes and generates #create" do
      {:post => "/sites"}.should route_to(
        :controller => "sites", :action => "create")
    end

    it "recognizes and generates #update" do
      {:put => "/sites/onehitwonders"}.should route_to(
        :controller => "sites", :action => "update", :id => "onehitwonders")
    end

    it "recognizes and generates #destroy" do
      {:delete => "/sites/onehitwonders"}.should route_to(
        :controller => "sites", :action => "destroy", :id => "onehitwonders")
    end

  end
end
