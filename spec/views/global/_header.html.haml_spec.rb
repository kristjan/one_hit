require 'spec_helper'

describe "global/_header.html.haml" do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

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
      mock_user(:name => Faker::Name.name, :email => Faker::Internet.email)
      view.stub(:viewer).and_return(mock_user)
    end

    it "says hello" do
      render
      assert_select ".greeting", :text => /Whatup/
    end

    it "addresses you if we know your name" do
      render
      assert_select ".greeting", :text => /#{mock_user.name}/
    end

    it "uses your email if we won't know a name" do
      mock_user.stub(:name).and_return(nil)
      render
      assert_select ".greeting", :text => /#{mock_user.email}/
    end

    it "links to your profile" do
      render
      assert_select ".greeting a[href=?]", user_path(mock_user)
    end

    it "links to the edit account page" do
      render
      assert_select ".greeting a[href=?]", edit_user_path(mock_user)
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
