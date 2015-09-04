require 'rails_helper'

describe Message do
  subject         { Message.new(from: sender, to: recipient, body: body) }
  let(:sender)    { "+14444444444" }
  let(:recipient) { "+15555555555" }

  describe '#tags' do
    it 'calls the TagParser with itself' do
      allow(TagParser).to receive(:run).with(subject)
      subject.tags
      expect(TagParser).to have_received(:run).with(subject)
    end
  end

  describe '#action' do
    context 'when the message is a recognizeable action' do
      let(:body) { "Register agent roberto" }

      it 'returns an instance of the Action' do
        expect(subject.action).to be_a(RegisterAction)
      end
    end

    context 'when the message is not a recognizeable action' do
      let(:body) { "hey y'all" }

      it 'returns an instance of NullAction' do
        expect(subject.action).to be_a(NullAction)
      end
    end
  end

  describe '#has_action?' do
    context 'when the message has a recognizeable action' do
      let(:body) { "Register agent roberto" }

      it 'is true' do
        expect(subject.has_action?).to be_truthy
      end
    end

    context 'when the message does not have recognizeable action' do
      let(:body) { "hey y'all" }

      it 'is false' do
        expect(subject.has_action?).to be_falsey
      end
    end
  end
end
