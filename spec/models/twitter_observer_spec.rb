require 'spec_helper'

describe TwitterObserver do
  def mock_twitter_client(stubs={})
    @mock_twitter_client ||= mock(Twitter::Client, stubs)
  end

  it "watches Sites" do
    TwitterObserver.instance.observed_classes.should include(Site)
  end

  describe "site creation" do
    before :each do
      @site = new_site
    end

    it "tweets the new site" do
      Twitter::Client.stub(:new).and_return(mock_twitter_client)
      mock_twitter_client.should_receive(:update)
      @site.save
    end

    it "includes a link to the site" do
      TwitterObserver.site_creation_tweet(@site).
        should include(UrlWriter.site_url(@site))
    end

    it "includes flashy newness" do
      TwitterObserver.site_creation_tweet(@site).should include("★")
    end

    it "includes the site's title" do
      TwitterObserver.site_creation_tweet(@site).should include(@site.name)
    end
  end

  describe "when Twitter fails" do
    before :each do
      @site = new_site
      Twitter::Client.stub(:new).and_return(mock_twitter_client)
      mock_twitter_client.should_receive(:update).and_raise(Twitter::Error)
    end

    it "still creates the site" do
      expect { @site.save }.to change(Site, :count).by(1)
    end

    it "notifies Hoptoad" do
      HoptoadNotifier.should_receive(:notify).
        with(an_instance_of(Twitter::Error))
      @site.save
    end
  end
end
