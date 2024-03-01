require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module IterableApiIntegration
  class Application < Rails::Application
    config.load_defaults 6.1
    config.action_dispatch.rescue_responses['Warden::NotAuthenticated'] = :unauthorized
    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies(:scope => :user).unshift :database_authenticatable
      # manager.failure_app = CustomFailureApp
    end
  end
end
