require 'spec_helper'

describe "sites/index.html.haml" do
  include ContentForTestHelper

  before :each do
    render
  end

  it "renders a link to make a new site" do
    assert_select "a[href=?]", new_site_path
  end

  it "renders a link to a random site" do
    assert_select "a[href=?]", random_sites_path
  end

  it "renders a link to the thanks page" do
    assert_select "a[href=?]", thanks_path
  end
end
