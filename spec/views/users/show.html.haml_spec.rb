require 'spec_helper'

describe "users/show.html.haml" do
  before :each do
    @user = assign(:user, stub_model(User,
      :name       => "MyString",
      :creator_id => 1))
  end

  it "shows this is the user's profile" do
    view.should_receive(:title).with "#{@user.first_name}'s Greatest Hits"
    render
  end

  it "shows a list of sites the user created" do
    @user.stub(:sites).and_return([new_site, new_site])
    render
    assert_select "#sites ul" do
      @user.sites.each do |site|
        assert_select "li" do
          assert_select "a[href=?]", site_path(site), :text => site.name
        end
      end
    end
  end

  it "shows the users badges" do
    @user.stub(:badges).and_return([new_badge, new_badge])
    render
    assert_select "#badges ul" do
      assert_select "li .badge", :count => 2
    end
  end
end
