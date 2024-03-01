require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
require 'rspec/rails'


require 'factory_bot_rails'
require 'rails-controller-testing'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include RSpec::Rails::ControllerExampleGroup, type: :controller
end
