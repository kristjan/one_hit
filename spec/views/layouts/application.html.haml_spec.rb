require 'spec_helper'

describe "layouts/application.html.haml" do
  before :each do
    view.stub(:viewer).and_return(nil)
  end

   it "renders a title when there is one" do
     @title = assign(:title, Faker::Lorem.sentence)
     render
     assert_select "h1", :text => @title
   end

   it "renders no title when nothing is present" do
     render
     assert_select "h1", :count => 0
   end

  it "renders accumulated stylesheets" do
    view.stub(:stylesheets).and_return(Set.new('three/to/the_wind'))
    render
    assert_select "link[href=?][rel=stylesheet][type=text/css]",
      "/stylesheets/three/to/the_wind.css"
  end
end
