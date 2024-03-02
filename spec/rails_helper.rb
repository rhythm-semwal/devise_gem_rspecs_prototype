require 'devise'
require File.expand_path('../config/environment', __dir__)
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'factory_bot_rails'
require 'rspec/rails'
require 'rails-controller-testing'

# Load FactoryBot factories
# Dir[Rails.root.join('spec', 'factories', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  Capybara.javascript_driver = :selenium
end
