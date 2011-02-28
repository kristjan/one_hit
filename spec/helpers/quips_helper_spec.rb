require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the QuipsHelper. For example:
#
# describe QuipsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe QuipsHelper do
  before(:all) do
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
