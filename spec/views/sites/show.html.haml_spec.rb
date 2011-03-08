require 'spec_helper'

describe "sites/show.html.haml" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :name       => "One hit wonders",
      :url        => "wonders",
      :creator_id => 1
    ))
  end

  it "shows a random quip" do
    quip = new_quip
    @site.stub(:random_quip).and_return(quip)
    render
    assert_select "p", :text => quip.text
  end

  describe "when there is more than one quip" do
    before :each do
      @site.stub(:quips).and_return([new_quip, new_quip])
    end

    it "gives you a way to get another quip" do
      render
      assert_select "a[href=#{site_path(@site)}]"
    end
  end

  describe "when there is one quip" do
    before :each do
      @site.stub(:quips).and_return([new_quip])
    end

    it "doesn't show the more button" do
      render
      assert_select "a.action", :count => 0
    end
  end

  describe "when there are no quips" do
    before :each do
      @site.stub(:quips).and_return([])
    end

    it "tells you so" do
      render
      assert_select "p.empty", :text => /nothing here/
    end

    it "links to add some" do
      render
      assert_select "a[href=#{site_quips_path(@site)}]"
    end
  end
end
