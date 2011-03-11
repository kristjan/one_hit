require "spec_helper"

describe UsersController do
  describe "routing" do

    it "recognizes and generates auth/twitter/callback" do
      {:get => "/auth/twitter/callback"}.should route_to(
        :controller => "users", :action => "create", :provider => 'twitter')
    end

  end
end
