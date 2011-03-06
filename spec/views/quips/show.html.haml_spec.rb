require 'spec_helper'

describe "quips/show.html.haml" do
  before(:each) do
    @quip = assign(:quip, new_quip)
    @site = assign(:site, @quip.site)
    @quip.id = 1
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Text/)
  end
end
