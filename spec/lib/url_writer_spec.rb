require 'spec_helper'

describe UrlWriter do
  include Rails.application.routes.url_helpers

  it "can generate a URL" do
    site = new_site
    UrlWriter.site_path(site).should == site_path(site)
  end
end
