require 'rails_helper'

describe TwilioClient do
  describe '.send' do
    let(:twilio_messages) { double('TwilioMessagesStub').as_null_object }

    let(:text_hash) { {} }

    before do
      allow(subject).to receive(:messages).and_return(twilio_messages)
      allow(twilio_messages).to receive(:create)
    end

    it 'posts a message via the Twilio API' do
      subject.send_text(text_hash)
      expect(twilio_messages).to have_received(:create).with(text_hash)
    end
  end

  describe '.fetch_incoming_messages' do
    let(:fake_messages) { [double('message', message_attributes)] }

    let(:message_attributes) do
      {
        sid: 1,
        to: '7',
        from: '7',
        body: 'hi',
        status: 'delivered'
      }
    end

    let(:creation_attributes) do
      {
        twilio_sid: 1,
        to: '7',
        from: '7',
        body: 'hi',
        status: 'delivered'
      }
    end

    before do
      allow(subject).to receive(:incoming_messages).and_return(fake_messages)
      allow(Message).to receive(:create).and_call_original
    end

    context 'when there is a new message on the server' do
    let(:fake_messages) { [double('message', message_attributes)] }

    let(:message_attributes) do
      {
        sid: 1,
        to: to,
        from: '7',
        body: 'hi',
        status: 'delivered'
      }
    end

    let(:creation_attributes) do
      {
        twilio_sid: 1,
        to: to,
        from: '7',
        body: 'hi',
        status: 'delivered'
      }
    end

    let(:to) { '7' }
      context 'when it is to the app' do
        it 'creates a message with the attributes' do
          subject.fetch_incoming_messages
          expect(Message).to have_received(:create).with(creation_attributes)
        end
      end
      context 'when it is to someone else' do
        it 'ignores it' do
          subject.fetch_incoming_messages
          subject.fetch_incoming_messages
          expect(Message).to have_received(:create).once
        end
      end
    end
  end
end
