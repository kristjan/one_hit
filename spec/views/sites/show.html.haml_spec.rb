require 'spec_helper'

describe "sites/show.html.haml" do
  include ContentForTestHelper

  before(:each) do
    @site = assign(:site, stub_model(Site,
      :name       => "One hit wonders",
      :url        => "wonders",
      :creator_id => 1
    ))
    view.stub(:viewer).and_return(new_user)
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

  describe "the nav" do
    describe "when you can edit it" do
      before :each do
        @site.stub(:editable_by?).and_return(true)
        render
      end

      it "shows an edit site link" do
        assert_select content_for(:nav), 'a[href=?]', edit_site_path(@site)
      end
      it "shows an edit quips link" do
        assert_select content_for(:nav), 'a[href=?]', site_quips_path(@site)
      end
    end

    describe "when you can not edit it" do
      before :each do
        @site.stub(:editable_by?).and_return(false)
        render
      end

      it "shows no edit links" do
        assert_select content_for(:nav), 'a', :count => 0
      end
    end
  end

  describe "the sharing bar" do
    it "lets you tweet" do
      render
      assert_select "a.twitter-share-button"
    end
  end
end
