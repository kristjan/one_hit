require 'spec_helper'

describe "quips/show.html.erb" do
  before(:each) do
    @quip = assign(:quip, new_quip)
    @site = assign(:site, @quip.site)
    @quip.id = 1
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text/)
  end
end
