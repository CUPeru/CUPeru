require 'rails_helper'

describe Exporter do
  before { Timecop.freeze(Time.new(2014, 12, 5, 8, 30)) }
  after  { Timecop.return }

  describe '.message_data' do
    subject { Exporter.new(scope).message_data }

    let(:incoming) { create(:incoming_message) }
    let(:outgoing) { create(:outgoing_message) }

    before do
      incoming
      outgoing
    end

    context 'when the scope is undefined' do
      let(:scope) { nil }

      it 'contains an array of all messages as row arrays' do
        expect(subject).to eq([incoming.to_row, outgoing.to_row])
      end
    end

    context 'when the scope is incoming' do
      let(:scope) { :incoming }

      it 'contains an array of incoming messages as row arrays' do
        expect(subject).to eq([incoming.to_row])
      end
    end

    context 'when the scope is outgoing' do
      let(:scope) { :outgoing }

      it 'contains an array of outgoing messages as row arrays' do
        expect(subject).to eq([outgoing.to_row])
      end
    end
  end
end
