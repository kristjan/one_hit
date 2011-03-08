require 'spec_helper'

describe "global/_header.html.haml" do
  it "renders a link to Home" do
    render
    assert_select "a[href=?]", root_path
  end

  it "renders a link to make a new site" do
    render
    assert_select "a[href=?]", new_site_path
  end

  it "renders a link to a random site" do
    render
    assert_select "a[href=?]", random_sites_path
  end

  it "renders a title when there is one" do
    @title = assign(:title, Faker::Lorem.sentence)
    render
    assert_select "h1", :text => @title
  end

  it "renders no title when nothing is present" do
    render
    assert_select "h1", :text => ""
  end
end
