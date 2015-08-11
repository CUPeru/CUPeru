require 'rails_helper'

describe TwilioController do
  context'#text' do
    it 'renders the valid twiml' do
      Message.create(body: 'I am a sample text', to: '+15555555555', from: '+15555555555', date_sent: "Thu, 06 Aug 2015 16:13:31 +0000")
      xml_type = "<Message>"

      post :text, format: :xml

      expect(response).to have_http_status(:ok)
      expect(Message.count).to eq(2)
      expect(Message.first.body).to eq("I am a sample text")
      expect(response.body.include?(xml_type)).to be(true)
    end
  end
end

