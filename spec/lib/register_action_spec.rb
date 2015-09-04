require 'rails_helper'

describe RegisterAction do
  subject { RegisterAction.new(message) }
  let(:message) { Message.new(to: "15555555555", from: "14444444444", body: body) }

  describe '#perform' do
    context 'when the message specifies an agent' do
      let(:body)    { "register agent roberto" }
      let(:details) { { phone_number: "14444444444", name: "roberto" } }

      it 'creates a new Agent with the appropriate details' do
        allow(Agent).to receive(:create)
        subject.perform
        expect(Agent).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies a health post' do
      let(:body)    { "register post 1337" }
      let(:details) { { phone_number: "14444444444", name: "1337" } }

      it 'creates a new HealthPost with the appropriate details' do
        allow(HealthPost).to receive(:create)
        subject.perform
        expect(HealthPost).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies a tecnico' do
      let(:body)    { "register tecnico roberto" }
      let(:details) { { phone_number: "14444444444", name: "roberto" } }

      it 'creates a new Tecnico with the appropriate details' do
        allow(Tecnico).to receive(:create)
        subject.perform
        expect(Tecnico).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies a health center' do
      let(:body)    { "register center iquitos" }
      let(:details) { { phone_number: "14444444444", name: "iquitos" } }

      it 'creates a new HealthCenter with the appropriate details' do
        allow(HealthCenter).to receive(:create)
        subject.perform
        expect(HealthCenter).to have_received(:create).with(details)
      end
    end

    context 'when the message specifies an invalid user type' do
      let(:body)    { "register juggler carl" }

      it 'raises an InvalidRegistrationError' do
        expect { subject.perform }.to raise_error(InvalidRegistrationError)
      end
    end
  end
end
