require 'spec_helper'

describe "users/new.html.haml" do
  before(:each) do
    assign(:user, stub_model(User,
      :name       => "MyString",
      :creator_id => 1
    ).as_new_record)
    view.stub(:next_url) {'/finish_line'}
  end

  it "renders the new user form" do
    render
    assert_select "form[action=?][method=?]", users_path, :post do
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_password[name=?][type=?]",
                    "user[password]", "password"
      assert_select "input#user_submit"
      assert_select "a#cancel[href=?]", '/finish_line'
    end
  end
end
