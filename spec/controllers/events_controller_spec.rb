require 'rails_helper'
require 'devise'

RSpec.describe EventsController, type: :controller do
  let(:current_user) { create(:user) }

  before do
    sign_in current_user
    @event1 = create(:event, title: 'Event 1', user: current_user)
    @event2 = create(:event, title: 'Event 2', user: current_user)
  end

  describe "GET #index" do
    it "renders the index template" do
      # Stub the current_user method to return a user
      allow(controller).to receive(:current_user).and_return(double('User').as_null_object)

      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create_event" do
    context "with valid event type" do
      it "creates an event and redirects with success notice" do
        post :create_event, params: { event_type: 'A' }
        expect(flash[:notice]).to eq("Event A created successfully.")
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid event type" do
      it "redirects with alert message" do
        post :create_event, params: { event_type: 'invalid' }
        expect(flash[:alert]).to eq("Invalid event type: invalid")
        expect(response).to redirect_to(events_path)
      end
    end

    context "with any other error" do
      it "redirects with alert message" do
        allow(IterableService).to receive(:create_event).and_raise(StandardError, "Something went wrong")
        post :create_event, params: { event_type: 'A' }
        expect(flash[:alert]).to start_with("An error occurred:")
        expect(response).to redirect_to(events_path)
      end
    end
  end
end
