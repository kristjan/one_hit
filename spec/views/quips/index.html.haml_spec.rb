require 'spec_helper'

describe "quips/index.html.haml" do
  before(:each) do
    @site = assign(:site, create_site)
    @quips = assign(:quips, [create_quip(:site => @site),
                             create_quip(:site => @site)])
  end

  it "renders a list of quips" do
    render

    assert_select "tr>td", :text => @site.name, :count => 2
    @quips.each do |quip|
      assert_select "tr>td", :text => quip.text
    end
  end
end
