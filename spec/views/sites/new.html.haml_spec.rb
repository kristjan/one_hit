require 'spec_helper'

describe "sites/new.html.haml" do
  before(:each) do
    assign(:site, stub_model(Site,
      :name => "MyString",
      :creator_id => 1
    ).as_new_record)
  end

  it "renders new site form" do
    render

    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_slug", :name => "site[slug]"
    end
  end
end
