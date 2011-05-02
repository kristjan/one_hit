require 'spec_helper'

describe "users/edit.html.haml" do
  before :each do
    @user = assign(:user, stub_model(User,
      :name  => Faker::Name.name,
      :email => Faker::Internet.email
    ))
    view.stub(:next_url).and_return("/")
  end

  it "renders the edit user form" do
    render
    assert_select "form[action=?]", user_path(@user) do
      assert_select "input#user_name[name=?]",  "user[name]"
      assert_select "input#user_email[name=?]", "user[email]"
    end
  end

  it "does not let you change your password yet" do
    render
    assert_select "input#user_password[name=?]", "user[password]", :count => 0
  end

  it "does not render 'login with <provider>'" do
    render
    assert_select "a[href=?]", auth_path(:twitter), :count => 0
  end

  it "does not render a cancel link" do
    render
    assert_select "a#cancel", :count => 0
  end

end
