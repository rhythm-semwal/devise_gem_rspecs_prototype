require 'rails_helper'
require 'factory_bot'
require 'faker'

require 'factory_bot_rails'

FactoryBot.define do
  factory :event do
    # sequence(:id) { |n| n }
    title { "Event #{id}" }
    # Add other attributes as needed
  end
end