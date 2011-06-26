require 'spec_helper'

describe "layouts/application.html.haml" do
  before :each do
    view.stub(:viewer).and_return(nil)
  end

  describe "the page title" do
    before(:each) do
      @title = assign(:title, Faker::Lorem.sentence)
      assign(:auto_header, true)
    end

    it "renders a title when there is one" do
      assign(:auto_header, true)
      render
      assert_select "h1", :text => @title
    end

    it "renders no title when nothing is present" do
      assign(:title, nil)
      render
      assert_select "h1", :count => 0
    end

    it "renders no title when it's asked not to" do
      assign(:auto_header, false)
      render
      assert_select "h1", :count => 0
    end
  end

  it "renders accumulated stylesheets" do
    view.stub(:stylesheets).and_return(Set.new('three/to/the_wind'))
    render
    assert_select "link[href=?][rel=stylesheet][type=text/css]",
      "/stylesheets/three/to/the_wind.css"
  end
end
