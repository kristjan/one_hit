require 'spec_helper'

describe "sites/show.html.haml" do
  include ContentForTestHelper

  before :each do
    @site = assign(:site, stub_model(Site,
      :name       => "One hit wonders",
      :url        => "wonders",
      :creator_id => 1
    ))
    view.stub(:viewer).and_return(new_user)
    view.stub(:pending_site?).and_return(false)
  end

  it "shows the assigned quip" do
    quip = assign(:quip, new_quip)
    render
    assert_select "p", :text => quip.text
  end

  describe "when there is more than one quip" do
    before :each do
      @site.stub(:singleton?).and_return(false)
    end

    it "gives you a way to get another quip" do
      render
      assert_select "a[href=#{site_path(@site)}]"
    end
  end

  describe "when there is one quip" do
    before :each do
      @site.stub(:singleton?).and_return(true)
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
      assert_select ".empty", :text => /nothing here/
    end

    it "links to add some" do
      render
      assert_select ".empty a[href=#{site_quips_path(@site)}]"
    end
  end

  describe "edit buttons" do
    before :each do
      assign(:quip, new_quip)
    end

    describe "when you can edit it" do
      before :each do
        @site.stub(:editable_by?).and_return(true)
        render
      end

      it "shows an edit site link" do
        assert_select content_for(:nav), 'a[href=?]', edit_site_path(@site)
      end

      it "links to add a quip" do
        assert_select '.quip a[href=?]', site_quips_path(@site),
                      :text => "+ Add Another"
      end
    end

    describe "when you can not edit it" do
      before :each do
        @site.stub(:editable_by?).and_return(false)
        render
      end


      it "does not link to add a quip" do
        assert_select '.quip a[href=?]', site_quips_path(@site),
                      :text => "+ Add Another", :count => 0
      end
    end
  end

  describe "the sharing bar" do
    it "lets you tweet" do
      render
      assert_select "a.twitter-share-button"
    end

    it "lets you like" do
      render
      assert_select ".fb_like"
    end
  end

  describe "the claim prompt" do
    context "when you have not claimed it" do
      before :each do
        view.stub(:pending_site?).and_return(true)
        render
      end

      it "appears" do
        content_for(:alert).to_s.should_not be_empty
      end

      it "includes links to log in / sign up" do
        assert_select content_for(:alert), 'a[href=?]',
                      new_user_path(:next_url => site_path(@site)),
                      :text => "Logging In"
        assert_select content_for(:alert), 'a[href=?]',
                      new_user_path(:next_url => site_path(@site)),
                      :text => "Signing Up"
      end
    end

    it "does not appear when you have no claim on it" do
      view.stub(:pending_site?).and_return(false)
      render
      content_for(:alert).to_s.should be_empty
    end
  end
end
