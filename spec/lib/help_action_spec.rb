require 'rails_helper'

describe HelpAction do
  subject          { HelpAction.new(message) }
  let(:message)    { Message.new(to: app_number, from: sender, body: body) }
  let(:app_number) { ENV['twilio_phone_number'] }
  let(:sender)     { "+15555555555" }

  describe '#perform' do
    let(:client) { double("client").as_null_object }
    let(:reply)  { { to: sender, from: app_number, body: reply_body } }

    before do
      stub_const("TwilioClient", client)
      allow(client).to receive(:send)
    end

    context 'when the request is for `register`' do
      let(:body)       { "help register" }
      let(:reply_body) { subject.send(:register_help) }

      it 'sends the register help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the request is for `info`' do
      let(:body)       { "help info" }
      let(:reply_body) { subject.send(:info_help) }

      it 'sends the info help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the request is for `broadcast`' do
      let(:body)       { "help broadcast" }
      let(:reply_body) { subject.send(:broadcast_help) }

      it 'sends the broadcast help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the request is for `auto`' do
      let(:body)       { "help auto" }
      let(:reply_body) { subject.send(:auto_help) }

      it 'sends the auto help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the request is for `fw`' do
      let(:body)       { "help fw" }
      let(:reply_body) { subject.send(:fw_help) }

      it 'sends the fw help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the request is anything else' do
      let(:body)       { "help" }
      let(:reply_body) { subject.send(:general_help) }

      it 'sends the general help message to the sender' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end
  end
end
