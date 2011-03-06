require 'spec_helper'

describe "quips/index.html.haml" do
  before(:each) do
    @site = assign(:site, create_site)
    @quips = assign(:quips, [create_quip(:site => @site),
                             create_quip(:site => @site)])
    @quip = assign(:quip, @site.quips.build)
  end

  it "renders a list of quips" do
    render

    @quips.each do |quip|
      assert_select "li", :text => /#{quip.text}/
    end
  end

  it "renders a field for a new quip" do
    render
    assert_select "form#new_quip[action=?]", site_quips_path(@site)
  end
end
