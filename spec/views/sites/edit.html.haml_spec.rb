require 'spec_helper'

describe "sites/edit.html.haml" do
  before :each do
    @site = assign(:site, stub_model(Site,
      :name       => "MyString",
      :url        => 'myurl',
      :creator_id => 1
    ))
  end

  it "renders the edit site form" do
    render
    assert_select "form[action=?]", site_path(@site) do
      assert_select "input#site_name[name=?]", "site[name]"
      assert_select "input#site_url[name=?]",  "site[url]"
    end
  end
end
