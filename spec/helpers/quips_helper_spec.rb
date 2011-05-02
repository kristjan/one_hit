require 'spec_helper'

describe QuipsHelper do
  before(:each) do
    @site = create_site
  end

  describe "the form path" do
    it "uses create for a new Quip" do
      quip = new_quip(:site => @site)
      form_path(quip).should == site_quips_path(@site)
    end

    it "uses update for an existing Quip" do
      quip = create_quip(:site => @site)
      form_path(quip).should == site_quip_path(@site, quip)
    end
  end
end
