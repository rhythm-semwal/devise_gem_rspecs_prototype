require 'rest-client'
require 'json'
require 'webmock/rspec'

class IterableService
  BASE_URL = 'https://api.iterable.com/api'
  API_KEY = 'YOUR_API_KEY'  # Replace with the actual API key

  # Public: Create an event for a user.
  #
  # user_id    - The ID of the user for whom the event is created.
  # event_type - The type of the event ('A' or 'B').
  #
  # Raises ArgumentError if the event_type is invalid.
  #
  # Returns nothing.
  def self.create_event(user_id, event_type)
    # Validate event type
    unless %w[A B].include?(event_type)
      raise ArgumentError, "Invalid event type: #{event_type}"
    end

    # Construct the API endpoint based on the event type
    event_api_url = "#{BASE_URL}/events/create_event_#{event_type.downcase}"

    begin
      WebMock.stub_request(:post, event_api_url)
             .with(body: { user_id: user_id })
             .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

      # Actual API request (comment this line out during testing)
      # response = RestClient.post(event_api_url, { user_id: user_id }, headers: { 'Api-Key': API_KEY })

      # Rest of the create_event method remains unchanged
      # result = JSON.parse(response.body)
      # puts "Event #{event_type} for user #{user_id}, Response: #{result}"

      # If scalability is a concern, we can leverage background job processing for sending email notification
      send_email_notification(user_id) if event_type == 'B'

    rescue RestClient::ExceptionWithResponse => e
      handle_api_error(e)
    rescue RestClient::Exception, StandardError => e
      handle_general_error(e)
    end
  end

  # Public: Send an email notification for a user.
  #
  # user_id - The ID of the user for whom the email notification is sent.
  #
  # Returns nothing.

  def self.send_email_notification(user_id)
    api_url = "#{BASE_URL}/notifications/send_email"

    begin
      WebMock.stub_request(:post, api_url)
             .with(body: { user_id: user_id })
             .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

      # Actual API request (comment this line out during testing)
      # response = RestClient.post(api_url, { user_id: user_id }, headers: { 'Api-Key': API_KEY })

      # Rest of the send_email_notification method remains unchanged
      # result = JSON.parse(response.body)
      # puts "Email notification #{user_id}, Response: #{result}"

    rescue RestClient::ExceptionWithResponse => e
      handle_api_error(e)
    rescue RestClient::Exception, StandardError => e
      handle_general_error(e)
    end
  end

  private

  # Handle API errors
  #
  # @param exception [Exception] The exception object
  def self.handle_api_error(exception)
    error_message = "API Error - Status Code: #{exception.response.code}, Error Message: #{exception.response.body}"
    Rails.logger.error(error_message)
    puts error_message
  end

  # Handle general errors
  #
  # @param exception [Exception] The exception object
  def self.handle_general_error(exception)
    error_message = "Error: #{exception.message}"
    Rails.logger.error(error_message)
    puts error_message
  end
end
