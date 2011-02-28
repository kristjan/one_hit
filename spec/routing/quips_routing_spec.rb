require "spec_helper"

describe QuipsController do
  describe "routing" do

    it "recognizes and generates #index" do
      {:get => "/onehitwonders/quips"}.should route_to(
        :controller => "quips", :action => "index",
        :site_id => "onehitwonders")
    end

    it "recognizes and generates #new" do
      {:get => "/onehitwonders/quips/new"}.should route_to(
        :controller => "quips", :action => "new",
        :site_id => "onehitwonders")
    end

    it "recognizes and generates #show" do
      {:get => "/onehitwonders/quips/1"}.should route_to(
        :controller => "quips", :action => "show", :id => "1",
      :site_id => "onehitwonders")
    end

    it "recognizes and generates #edit" do
      {:get => "/onehitwonders/quips/1/edit"}.should route_to(
        :controller => "quips", :action => "edit", :id => "1",
      :site_id => "onehitwonders")
    end

    it "recognizes and generates #create" do
      {:post => "/onehitwonders/quips"}.should route_to(
        :controller => "quips", :action => "create",
      :site_id => "onehitwonders")
    end

    it "recognizes and generates #update" do
      {:put => "/onehitwonders/quips/1"}.should route_to(
        :controller => "quips", :action => "update", :id => "1",
      :site_id => "onehitwonders")
    end

    it "recognizes and generates #destroy" do
      {:delete => "/onehitwonders/quips/1"}.should route_to(
        :controller => "quips", :action => "destroy", :id => "1",
      :site_id => "onehitwonders")
    end

  end
end
