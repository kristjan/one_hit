class UrlWriter
  include Rails.application.routes.url_helpers

  default_url_options[:host] = 'oneh.it'

  def self.instance
    @@instance ||= new
  end

  def self.method_missing(method, *args)
    instance.send(method, *args)
  end
end
