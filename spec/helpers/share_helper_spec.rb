require 'spec_helper'

describe ShareHelper do
  before :each do
    @site = create_site
  end

  describe "the Facebook button" do
    it "generate an fb:like" do
      like_button(@site).should =~ %r(<fb:like)
    end

    it "sets the right URL" do
      like_button(@site).should =~ %r(href="#{site_url(@site)}")
    end

    it "sets the layout" do
      like_button(@site).should =~ %r(layout="button_count")
    end

    it "turns faces off by default" do
      like_button(@site).should =~ %r(show_faces="false")
    end

    it "lets you set the layout" do
      like_button(@site, :layout => 'box_count').should =~
        %r(layout="box_count")
    end

    it "lets you turn faces on" do
      like_button(@site, :faces => true).should =~ %r(show_faces="true")
    end
  end

  describe "the Twitter button" do
    it "has the right link" do
      tweet_button(@site).should =~ %r(http://twitter.com/share)
    end

    it "sets the site's URL" do
      tweet_button(@site).should =~ %r(data-url="#{site_url(@site)}")
    end

    it "sets a canonical URL" do
      tweet_button(@site).should =~
        %r(data-counturl="#{site_url(@site)}")
    end

    it "sets the layout" do
      tweet_button(@site).should =~ %r(data-count="horizontal")
    end

    it "recommends Twitter accounts after the tweet" do
      tweet_button(@site).should =~ %r(data-related="kripet")
    end

    it "lets you set the URL" do
      tweet_button(@site, :url => 'google.com').should =~
        %r(data-url="google.com")
    end

    it "uses the Site's canonical URL even when another is present" do
      tweet_button(@site, :url => 'google.com').should =~
        %r(data-counturl="#{site_url(@site)}")
    end

    it "lets you set the layout" do
      tweet_button(@site, :style => 'vertical').should =~
        %r(data-count="vertical")
    end

    it "lets you set the canonical URL" do
      tweet_button(@site, :canonical_url => 'google.com').should =~
        %r(data-counturl="google.com")
    end
  end
end
