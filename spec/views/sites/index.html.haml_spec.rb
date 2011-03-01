require 'spec_helper'

describe "sites/index.html.haml" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :name => "Name",
        :slug => 'slug1',
        :creator_id => 1
      ),
      stub_model(Site,
        :name => "Name",
        :slug => 'slug2',
        :creator_id => 1
      )
    ])
  end

  it "renders a list of sites" do
    render

    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
