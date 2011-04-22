require "spec_helper"

describe "named routes" do
  it "recognized and generates #thanks" do
    {:get => "/thanks"}.should route_to(
      :controller => "sites", :action => "show", :id => 'thanks'
    )
  end
end
