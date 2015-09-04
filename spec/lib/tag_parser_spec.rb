require 'rails_helper'

describe TagParser do
  let(:message) { double("Message", body: body) }

  describe '#run' do
    context 'when the message contains one tag' do
      let(:body) { "emergency No estoy aqui" }

      it 'returns the keyword wrapped in an array' do
        expect(subject.run(message)).to eq([:emergency])
      end
    end

    context 'when the message contains multiple keywords' do
      let(:body) { "emergency broadcast No estoy aqui" }

      it 'returns the keywords wrapped in an array' do
        expect(subject.run(message)).to eq([:emergency, :broadcast])
      end
    end

    context 'when the message contains no keywords' do
      let(:body) { "No estoy aqui" }

      it 'returns an empty array' do
        expect(subject.run(message)).to eq([])
      end
    end
  end
end
