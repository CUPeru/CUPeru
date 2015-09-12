require 'rails_helper'

describe Exporter do
  describe '.message_data' do
    subject { Exporter.message_data(scope) }

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

  describe '.all_messages' do
    subject { Exporter.run }

    let(:incoming)     { create(:incoming_message) }
    let(:outgoing)     { create(:outgoing_message) }
    let(:registration) { create(:incoming_message, :register) }

    before do
      incoming
      outgoing
      registration
    end

    let(:csv_output) do
      "sender,recipient,body,tags,action,date\n" +
        message_to_string(incoming) +
        message_to_string(outgoing) +
        message_to_string(registration)
    end

    it 'renders a CSV of all messages' do
      expect(File.read(subject)).to eq(csv_output)
    end
  end
end

def message_to_string(message)
  message.to_row.join(",") + "\n"
end
