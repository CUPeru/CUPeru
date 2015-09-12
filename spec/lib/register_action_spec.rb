require 'rails_helper'

describe RegisterAction do
  subject { RegisterAction.new(message) }

  let(:message) do
    Message.new(
      to:   app_number,
      from: sender,
      body: body)
  end

  let(:app_number) { ENV['twilio_phone_number'] }
  let(:sender)     { "15555555555" }

  let(:client)     { double("client").as_null_object }

  before do
    stub_const("TwilioClient", client)
    allow(client).to receive(:send_text)
  end

  describe '#perform' do
    let(:details) { { phone_number: sender, name: "roberto" } }

    context 'on successful registration' do
      let(:body)       { "register agent roberto" }
      let(:reply)      { { to: sender, from: app_number, body: reply_body } }
      let(:reply_body) { subject.send(:confirmation_message) }

      it 'creates a confirmation message' do
        subject.perform
        expect(client).to have_received(:send_text).with(reply)
      end
    end

    context 'when the message specifies an agent' do
      let(:body)    { "register agent roberto" }

      it 'creates a new Agent with the appropriate details' do
        allow(Agent).to receive(:create)
        subject.perform
        expect(Agent).to have_received(:create).with(details)
      end

      it 'sends a confirmation message' do

      end
    end

    context 'when the message specifies a health post' do
      let(:body)    { "register post roberto" }

      it 'creates a new HealthPost with the appropriate details' do
        allow(HealthPost).to receive(:create)
        subject.perform
        expect(HealthPost).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies a tecnico' do
      let(:body)    { "register tecnico roberto" }

      it 'creates a new Tecnico with the appropriate details' do
        allow(Tecnico).to receive(:create)
        subject.perform
        expect(Tecnico).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies a health center' do
      let(:body)    { "register center roberto" }

      it 'creates a new HealthCenter with the appropriate details' do
        allow(HealthCenter).to receive(:create)
        subject.perform
        expect(HealthCenter).to have_received(:create).with(details)
      end
    end

    context 'when the syntax is invalid' do
      let(:body)       { "register" }
      let(:reply)      { { to: sender, from: app_number, body: reply_body } }
      let(:reply_body) { HelpAction.new(message).send(:general_help) }

      it 'performs a HelpAction with `register`' do
        allow(subject).to receive(:reply)
        subject.perform
        expect(subject).to have_received(:reply)
      end
    end
  end
end
