# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
Rails.application.load_tasks

Rake::TaskManager.class_eval do
  private

  def rake_application
    @rake_application ||= begin
                            require 'rails/all'
                            require 'factory_bot_rails'
                            FactoryBot.definition_file_paths << File.expand_path('factories', __dir__)
                            FactoryBot.find_definitions
                            Rails.application
                          end
  end
end