require 'rails_helper'

describe TwilioController do
  context '#text' do
    it 'renders the valid twiml' do
      health_post = HealthPost.create
      health_post.update_attributes(code: "9599")
      agent = Agent.create(health_post_id: health_post.id)
      message = agent.messages.create(body: 'I am a sample text', to: '+15555555555', from: '+15555555555', date_sent: "Thu, 06 Aug 2015 16:13:31 +0000")
      xml_type = "<Message>"

      post :text, format: :xml

      expect(response).to have_http_status(:ok)
      expect(Message.count).to eq(2)
      expect(Message.first.body).to eq("I am a sample text")
      expect(response.body.include?(xml_type)).to be(true)
    end
  end

  context 'helper' do
    it 'correctly finds healthcare workers' do
      number = rand(10000000000..9999999999).to_s
      agent = Agent.create!(phone_number: rand)
      tecnico = Tecnico.create!(phone_number: rand)
      a_message = Message.create(messageable_type: Agent, messageable_id: agent.id)
      t_message = Message.create(messageable_type: Tecnico, messageable_id: tecnico.id)

      found_agent = TwilioController.new.find_healthcare_worker(a_message)
      found_tecnico = TwilioController.new.find_healthcare_worker(t_message)

      expect(found_agent).to eq(agent)
      expect(found_tecnico).to eq(tecnico)
    end
  end
end

