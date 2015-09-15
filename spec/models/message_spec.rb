# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  body             :string
#  to               :string
#  from             :string
#  date_sent        :string
#  keyword          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :integer
#  messageable_type :string
#  status           :string
#  twilio_sid       :string
#

require 'rails_helper'

describe Message do
  subject { create(:incoming_message) }

  describe '#tags' do
    it 'calls the TagParser with itself' do
      allow(TagParser).to receive(:run).with(subject)
      subject.tags
      expect(TagParser).to have_received(:run).with(subject)
    end
  end

  describe '#action' do
    context 'when the message is a recognizeable action' do
      subject { create(:incoming_message, :register) }

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
end
