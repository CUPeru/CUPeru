require 'rails_helper'

describe TwilioClient do
  let(:twilio_messages) { double('TwilioMessagesStub').as_null_object }
  let(:twilio_client)   { double('TwilioClientStub').as_null_object }

  let(:text_hash) { {} }

  before do
    stub_const('Twilio::REST::Client', twilio_client)
    allow(twilio_client).to receive(:messages).and_return(twilio_messages)
    allow(twilio_messages).to receive(:create)
  end

  describe '.send' do
    it 'posts a message via the Twilio API' do
      twilio_messages.create(text_hash)
      expect(twilio_messages).to have_received(:create).with(text_hash)
    end
  end
end
