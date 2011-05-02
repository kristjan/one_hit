class TwitterObserver < ActiveRecord::Observer
  observe :site

  def self.site_creation_tweet(site)
    "★ #{UrlWriter.site_url(site)} | #{site.name}"
  end

  def after_create(model)
    case model
    when Site
      Twitter::Client.new.update(self.class.site_creation_tweet(model))
    end
  end

private

  def client
    @client ||= Twitter::Client.new
  end
end
