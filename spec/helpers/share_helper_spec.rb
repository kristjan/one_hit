require 'spec_helper'

describe ShareHelper do
  before(:all) do
    @site = create_site
  end

  describe "the twitter button" do
    it "has the right link" do
      twitter_share_button(@site).should =~ %r(http://twitter.com/share)
    end

    it "sets the site's URL" do
      twitter_share_button(@site).should =~ %r(data-url="#{site_url(@site)}")
    end

    it "sets a canonical URL" do
      twitter_share_button(@site).should =~
        %r(data-counturl="#{site_url(@site)}")
    end

    it "sets the layout" do
      twitter_share_button(@site).should =~ %r(data-count="horizontal")
    end

    it "recommends Twitter accounts after the tweet" do
      twitter_share_button(@site).should =~ %r(data-related="kripet")
    end

    it "lets you set the URL" do
      twitter_share_button(@site, :url => 'google.com').should =~
        %r(data-url="google.com")
    end

    it "uses the Site's canonical URL even when another is present" do
      twitter_share_button(@site, :url => 'google.com').should =~
        %r(data-counturl="#{site_url(@site)}")
    end

    it "lets you set the layout" do
      twitter_share_button(@site, :style => 'vertical').should =~
        %r(data-count="vertical")
    end

    it "lets you set the canonical URL" do
      twitter_share_button(@site, :canonical_url => 'google.com').should =~
        %r(data-counturl="google.com")
    end
  end
end
