require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module OneHit
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.active_record.observers = :badge_observer
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end
