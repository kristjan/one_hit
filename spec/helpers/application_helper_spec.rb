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

  describe "Google Fonts" do
    it "writes a link tag" do
      google_font_link_tag('Font').should =~ /<link/
    end

    it "loads from the right host" do
      google_font_link_tag('Font').should =~
        %r(href="http://fonts.googleapis.com/css[^"]*")
    end

    it "loads the right Font" do
      google_font_link_tag('Font').should =~
        %r(href="[^"]*\?family=Font[^"]*")
    end

    it "handles fonts with many words" do
      google_font_link_tag('Cooler Font').should =~ /Cooler\+Font/
    end

    it "loads all font styles" do
      google_font_link_tag('Font').should =~ /Font:regular,b,i,bi/
    end

    it "sets the stylesheet relation" do
      google_font_link_tag('Font').should =~ /rel="stylesheet"/
    end

    it "sets the content type" do
      google_font_link_tag('Font').should =~ %r(type="text/css")
    end
  end
end
