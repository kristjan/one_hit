require 'compass'
require 'compass/app_integration/rails'
Compass::AppIntegration::Rails.initialize!

if Rails.env.production?
  Compass.configuration.sass_options ||= {}
  Compass.configuration.sass_options[:never_update] = true
end
