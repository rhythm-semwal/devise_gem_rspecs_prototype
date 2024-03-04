require 'rails_helper'
require 'devise'
require 'iterable_service'

RSpec.describe IterableService, type: :service do
  describe ".create_event" do
    context "with valid event type 'B'" do
      let(:user_id) { 1 }

      it "makes a successful POST request to the correct API endpoint" do
        WebMock.stub_request(:post, "https://api.iterable.com/api/events/create_event_b")
               .with(body: { user_id: user_id })
               .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

        # Invoke the method
        IterableService.create_event(user_id, 'B')
      end

      it "sends an email notification" do
        WebMock.stub_request(:post, "https://api.iterable.com/api/events/create_event_b")
               .with(body: { user_id: user_id })
               .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

        # Expect the method to be called
        expect(IterableService).to receive(:send_email_notification).with(user_id)

        # Invoke the method
        IterableService.create_event(user_id, 'B')
      end
    end

    context "with valid event type 'A'" do
      let(:user_id) { 1 }

      it "makes a successful POST request to the correct API endpoint" do
        WebMock.stub_request(:post, "https://api.iterable.com/api/events/create_event_a")
               .with(body: { user_id: user_id })
               .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

        # Invoke the method
        IterableService.create_event(user_id, 'A')
      end

      it "does not send email notification" do
        WebMock.stub_request(:post, "https://api.iterable.com/api/events/create_event_a")
               .with(body: { user_id: user_id })
               .to_return(status: 200, body: '{"status": "success"}', headers: { 'Content-Type': 'application/json' })

        # Expect the send_email_notification not be called
        expect(IterableService).not_to receive(:send_email_notification).with(user_id)

        # Invoke the method
        IterableService.create_event(user_id, 'A')
      end
    end

    context "with invalid event type" do
      let(:user_id) { 1 }
      let(:invalid_event_type) { 'X' }

      it "raises an ArgumentError" do
        expect { IterableService.create_event(user_id, invalid_event_type) }.to raise_error(ArgumentError)
      end
    end
  end
end
