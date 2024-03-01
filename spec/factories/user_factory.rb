require 'rails_helper'
require 'factory_bot'
require 'faker'

require 'factory_bot_rails'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
  end
end
