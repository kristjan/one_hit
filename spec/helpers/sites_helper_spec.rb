require 'spec_helper'

describe SitesHelper do
  describe "tips" do
    before :each do
      @tip = tip(:test)
    end

    it "generates an image_tag" do
      @tip.should =~ /<img.*>/
    end

    it "points at the right image" do
      @tip.should =~ %r(src="/images/tips/test\.png")
    end

    it "adds the tip class" do
      @tip.should =~ /class="tip"/
    end
  end
end
