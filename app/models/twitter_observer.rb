class TwitterObserver < ActiveRecord::Observer
  observe :site

  def self.site_creation_tweet(site)
    "★ #{UrlWriter.site_url(site)} | #{site.name}"
  end

  def after_create(model)
    case model
    when Site
      client.update(self.class.site_creation_tweet(model))
    end
  rescue Twitter::Error => oboe
    HoptoadNotifier.notify(oboe)
  end

private

  def client
    Twitter::Client.new
  end
end
