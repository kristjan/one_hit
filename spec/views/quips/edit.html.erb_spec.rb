require 'spec_helper'

describe "quips/edit.html.erb" do
  before(:each) do
    @quip = assign(:quip, create_quip)
    @site = assign(:site, @quip.site)
  end

  it "renders the edit quip form" do
    render

    assert_select "form", :action => site_quips_path(@site, @quip), :method => "post" do
      assert_select "input#quip_site_id", :name => "quip[site_id]"
      assert_select "input#quip_text", :name => "quip[text]"
    end
  end
end
