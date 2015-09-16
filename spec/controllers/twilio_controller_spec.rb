require 'rails_helper'

describe TwilioController do
  let(:sender)         { '+14444444444' }
  let(:app_phone)      { ENV['twilio_phone_number'] }
  let(:body)           { "hi" }

  let(:dispatcher) { double('dispatcher').as_null_object }
  let(:client)     { double('client').as_null_object }

  before do
    stub_const("Dispatcher", dispatcher)
    stub_const('TwilioClient', client)
  end

  describe 'POST create' do
    let(:post_params)    { { to: sender, body: body } }
    let(:message)        { create(:message, message_params) }
    let(:message_params) { { to: sender, from: app_phone, body: body } }

    it 'creates a message' do
      allow(Message).to receive(:create) { message }
      post :create, post_params
      expect(Message).to have_received(:create).with(message_params)
    end

    it 'sends the message' do
      allow(client).to receive(:send_text)
      post :create, post_params
      expect(client).to have_received(:send_text)
    end
  end
end
