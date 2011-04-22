require 'spec_helper'

describe ApplicationHelper do
  it "sets the page title" do
    title "of the song"
    @title.should == "of the song"
  end

  it "can accumulate a stylesheet for later" do
    stylesheets.should be_empty
    add_stylesheet 'three/to/the_wind'
    stylesheets.should include('three/to/the_wind')
  end
end
