ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require Rails.root.join("spec/support/models.rb")
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

include Fixjour

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true

  config.before :each do
    Twitter::Client.stub(:new).and_return(mock.as_null_object)
  end
end
