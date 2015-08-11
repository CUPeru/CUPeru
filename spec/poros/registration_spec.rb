require 'rails_helper'
require_relative '../../app/poro/sms_registration.rb'

describe Registrator do
  xit 'registers agents' do
    message = double()
    message.stub(:from).and_return("1234567890")
    message.stub(:body).and_return("agent123")
    agent = Registrator.new(message).register_by_number(message)

    expect(agent).to eq(Agent)
    expect(agent.phone_number).to eq(message.phone_number)
  end
end

