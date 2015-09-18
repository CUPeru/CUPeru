require 'rails_helper'

describe IncomingMessagesWorker do
  it { is_expected.to be_retryable(5) }
  it { is_expected.to be_unique }

  describe '#perform' do
    it 'calls .fetch_incoming_messages' do
      allow(TwilioClient).to receive(:fetch_incoming_messages)
      subject.perform
      expect(TwilioClient).to have_received(:fetch_incoming_messages)
    end
  end
end
