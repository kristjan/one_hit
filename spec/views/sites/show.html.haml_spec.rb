require 'spec_helper'

describe "sites/show.html.haml" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :name => "One hit wonders",
      :slug => "wonders",
      :creator_id => 1
    ))
    @quip = new_quip
    @site.stub(:random_quip).and_return(@quip)
  end

  it "shows a random quip" do
    render
    assert_select "p", :text => @quip.text
  end

  it "gives you a way to get another quip" do
    render
    assert_select "a", :href => @site
  end
end
