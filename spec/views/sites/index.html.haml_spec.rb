require 'spec_helper'

describe "sites/index.html.haml" do
  it "renders a link to make a new site" do
    render
    assert_select "a[href=#{new_site_path}]"
  end

  it "renders a link to a random site" do
    render
    assert_select "a[href=#{random_sites_path}]"
  end
end
