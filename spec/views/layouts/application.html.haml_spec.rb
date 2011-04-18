require 'spec_helper'

describe "layouts/application.html.haml" do
  before :each do
    view.stub(:viewer).and_return(nil)
  end

  it "renders accumulated stylesheets" do
    view.stub(:stylesheets).and_return(Set.new('three/to/the_wind'))
    render
    assert_select "link[href=?][rel=stylesheet][type=text/css]",
      "/stylesheets/three/to/the_wind.css"
  end
end
