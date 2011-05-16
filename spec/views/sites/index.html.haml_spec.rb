require 'spec_helper'

describe "sites/index.html.haml" do
  include ContentForTestHelper

  before :each do
    @sites = assign(:sites, [new_site, new_site, new_site])
    @sites.each {|site| site.stub(:random_quip).and_return(new_quip)}
    render
  end

  it "renders a link to make a new site" do
    assert_select "a[href=?]", new_site_path
  end

  it "renders a link to a random site" do
    assert_select "a[href=?]", random_sites_path
  end

  it "renders a link to the thanks page" do
    assert_select "a[href=?]", thanks_path
  end

  it "renders a set of sites" do
    render
    assert_select ".examples" do
      @sites.each do |site|
        assert_select ".site" do
          assert_select "h1", :text => site.name
          assert_select "p", :text => site.random_quip.text
        end
      end
    end
  end
end
