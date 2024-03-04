class EventsController < ApplicationController
  before_action :authenticate_user!,  only: [:index]

  # Display a list of events for the current users
  def index
    puts "current_user = #{current_user.inspect}"
    @events = current_user.events
    # You may want to load users data or perform other actions here
  end

  # Create an event for the current users based on the specified event type
  def create_event
    event_type = params[:event_type]

    begin
      # Call IterableService to create the event
      IterableService.create_event(current_user.id, event_type)
      flash[:notice] = "Event #{event_type} created successfully."
    rescue ArgumentError => e
      # Handle ArgumentError (invalid event type)
      flash[:alert] = "#{e.message}"
    rescue StandardError => e
      # Handle other errors
      flash[:alert] = "An error occurred: #{e.message}"
    end

    redirect_to events_path
  end

  def destroy_user_session
    puts  '********'
    puts 'destroying user session'
    sign_out(current_user)
    redirect_to new_user_session_path # Redirect to the sign-in page
  end
end
