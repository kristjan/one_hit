require 'spec_helper'

describe "global/_header.html.haml" do
  before :each do
    view.stub(:viewer).and_return(nil)
  end

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

  describe "when you are logged in" do
    before :each do
      @user = new_user
      view.stub(:viewer).and_return(@user)
    end

    it "says hello" do
      render
      assert_select ".greeting", :text => /Whatup/
    end

    it "addresses you if we know your name" do
      render
      assert_select ".greeting", :text => /#{@user.name}/
    end

    it "uses your email if we won't know a name" do
      @user.name = nil
      render
      assert_select ".greeting", :text => /#{@user.email}/
    end
  end

  describe "when you are not logged in" do
    before :each do
      view.stub(:viewer).and_return(nil)
    end

    it "renders a login button" do
      render
      assert_select ".greeting a", :text => "Log in"
    end
  end
end
