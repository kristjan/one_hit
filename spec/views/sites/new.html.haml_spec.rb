require 'spec_helper'

describe "sites/new.html.haml" do
  before :each do
    assign(:site, stub_model(Site,
      :name       => "MyString",
      :creator_id => 1
    ).as_new_record)
    render
  end

  it "renders the new site form" do
    render
    assert_select "form[action=?][method=?]", sites_path, :post do
      assert_select "input#site_name[name=?]", "site[name]"
      assert_select "input#site_url[name=?]",  "site[url]"
    end
  end

  describe "helpful tips" do
    it "renders a name tip" do
      assert_select ".field.name img.tip"
    end

    it "renders a URL tip" do
      assert_select ".field.url img.tip"
    end
  end
end
