class EventsController < ApplicationController
  before_action :authenticate_user!,  only: [:index]

  # Display a list of events for the current user
  def index
    @events = current_user.events
    # You may want to load user data or perform other actions here
  end

  # Create an event for the current user based on the specified event type
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
end
