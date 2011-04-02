require "spec_helper"

describe UsersController do
  describe "routing" do

    it "recognizes and generates auth/twitter/callback" do
      {:get => "/auth/twitter/callback"}.should route_to(
        :controller => "users", :action => "authorize",
        :provider => 'twitter')
    end

    it "recognizes and generates #edit" do
      {:get => "/users/1/edit"}.should route_to(
        :controller => "users", :action => "edit", :id => "1")
    end

    it "recognizes and generates #show" do
      {:get => "/users/1"}.should route_to(
        :controller => "users", :action => "show", :id => "1")
    end

    it "recognizes and generates #update" do
      {:put => "/users/1"}.should route_to(
        :controller => "users", :action => "update", :id => "1")
    end
  end
end
