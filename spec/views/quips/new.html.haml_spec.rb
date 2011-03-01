require 'spec_helper'

describe "quips/new.html.haml" do
  before(:each) do
    @quip = assign(:quip, new_quip)
    @site = assign(:site, @quip.site)
  end

  it "renders new quip form" do
    render

    assert_select "form", :action => site_quips_path(@site), :method => "post" do
      assert_select "input#quip_site_id", :name => "quip[site_id]"
      assert_select "input#quip_text", :name => "quip[text]"
    end
  end
end
