require 'rails_helper'

describe MessageCSVPresenter do
  subject { MessageCSVPresenter.new(message) }

  describe '#to_row' do
    let(:message) do
      create(:message,
             from:       '15554443333',
             to:         '18887776666',
             body:       body,
             created_at: date)
    end
    let(:date)   { DateTime.new(2014,12,5,8,25) }

    context 'when the message is a plain message' do
      let(:body)   { "body string" }

      let(:result) do
        ['15554443333', '18887776666', body,
         nil, nil, date]
      end

      it 'returns the expected array' do
        expect(subject.to_row).to eq(result)
      end
    end

    context 'when the message has a tag' do
      let(:body)   { "emergency body string" }

      let(:result) do
        ['15554443333', '18887776666', body,
         'emergency', nil, date]
      end

      it 'returns the expected array' do
        expect(subject.to_row).to eq(result)
      end

    end

    context 'when the message has multiple tags' do
      let(:body)   { 'emergency symptom body string' }

      let(:result) do
        ['15554443333', '18887776666', body,
         'emergency symptom', nil, date]
      end

      it 'returns the expected array' do
        expect(subject.to_row).to eq(result)
      end

    end

    context 'when the message has an action' do
      let(:body)   { 'register agent anna' }

      let(:result) do
        ['15554443333', '18887776666', body,
         nil, 'register', date]
      end

      it 'returns the expected array' do
        expect(subject.to_row).to eq(result)
      end
    end
  end
end
