require 'rails_helper'

describe TwilioClient do
  let(:messages)    { double("Messages").as_null_object }
  let(:text_hash)   { {} }

  describe '.send' do
    before { allow(subject).to receive(:messages) { messages } }

    it 'posts a message via the Twilio API' do
      subject.send_text(text_hash)
      expect(messages).to have_received(:create).with(text_hash)
    end
  end
end
