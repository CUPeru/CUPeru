require 'rails_helper'

describe TwilioController do
  let(:sender)         { '+14444444444' }
  let(:app_phone)      { ENV['twilio_phone_number'] }
  let(:body)           { "hi" }
  let(:message_params) { { to: app_phone, from: sender, body: body } }

  let(:dispatcher) { double('dispatcher').as_null_object }

  before { stub_const("Dispatcher", dispatcher) }

  describe 'POST create' do
    it 'creates a message' do
      allow(Message).to receive(:create)
      post :create, message_params, format: :json
      expect(Message).to have_received(:create).with(message_params)
    end

    it 'dispatches the message' do
      allow(dispatcher).to receive(:route)
      post :create, message_params, format: :json
      expect(dispatcher).to have_received(:route)
    end

    it 'has a status of created' do
      post :create, message_params, format: :json
      expect(response.status).to eq(201)
    end
  end
end
