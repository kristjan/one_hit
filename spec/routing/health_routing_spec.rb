require "spec_helper"

describe HealthController do
  describe "routing" do
    it "recognizes and generates #oops" do
      {:get => "/health/oops"}.should route_to(
        :controller => "health", :action => "oops")
    end

    it "recognizes and generates #oops_js" do
      {:get => "/health/oops_js"}.should route_to(
        :controller => "health", :action => "oops_js")
    end
  end
end
