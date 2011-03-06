require 'spec_helper'

describe Site do
  it "builds a valid object" do
    new_site.should be_valid
  end

  it "requires a name" do
    Site.new.should have(1).error_on(:name)
    Site.new(:name => '').should have(1).error_on(:name)
  end

  it "requires a url" do
    Site.new.should have(1).error_on(:url)
    Site.new(:url => '').should have(1).error_on(:url)
  end

  it "doens't require an author" do
    Site.new.should have(:no).errors_on(:author_id)
  end

  it "uses its url in the URL" do
    site = new_site
    site.to_param.should == site.url
  end

  it "has many Quips" do
    new_site.quips.should be_a(Array)
  end

  it "fetches random quips" do
    site = new_site
    site.quips = [new_quip(:site => site), new_quip(:site => site)]
    site.quips.should include(site.random_quip)
  end

  describe "the url" do
    it "allows alphas" do
      new_site(:url => "AbCd").should be_valid
    end

    it "allows numbers" do
      new_site(:url => "123").should be_valid
    end

    it "allows dashes and underscores" do
      new_site(:url => "a-b_c").should be_valid
    end

    it "doesn't allow funny characters" do
      new_site(:url => "ain't@cool").should_not be_valid
    end

    it "must be unique" do
      site = create_site
      new_site(:url => site.url).should have(1).error_on(:url)
    end
  end
end
