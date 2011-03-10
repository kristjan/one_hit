require 'spec_helper'

describe ApplicationHelper do
  it "sets the page title" do
    title "of the song"
    @title.should == "of the song"
  end
end
