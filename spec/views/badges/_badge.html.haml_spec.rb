require 'spec_helper'

describe "badges/_badge.html.haml" do
  before :each do
    @badge = new_badge
    view.stub(:badge).and_return(@badge)
    render
  end

  it "renders the badge's image" do
    assert_select "img[src$=?][alt=?][title='']",
      @badge.image_path, @badge.to_s
  end

  it "renders the badge's flyover" do
    assert_select ".flyover" do
      assert_select "h3", :text => @badge.to_s
      assert_select "p",  :text => @badge.description
    end
  end
end
