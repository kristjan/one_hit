require 'spec_helper'

describe "sites/show.html.erb" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :name => "Name",
      :slug => "slug",
      :creator_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
