require 'spec_helper'

describe "quips/index.html.erb" do
  before(:each) do
    @site = assign(:site, create_site)
    @quips = assign(:quips, [create_quip(:site => @site),
                             create_quip(:site => @site)])
  end

  it "renders a list of quips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @site.name, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    @quips.each do |quip|
      assert_select "tr>td", :text => quip.text
    end
  end
end
