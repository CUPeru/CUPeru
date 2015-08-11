require 'rails_helper'
require_relative '../../app/poro/sms_registration.rb'

describe Registrator do
  it 'registers agents' do
    expect(Agent.count).to eq(0)

    message = double()
    message.stub(:from).and_return("1234567890")
    message.stub(:body).and_return("agent123")

    agent = Registrator.new.register_by_number(message)

    expect(agent.class).to eq(Agent)
    expect(Agent.count).to eq(1)
  end

  it 'registers tecnicos' do
    expect(Agent.count).to eq(0)

    message = double()
    message.stub(:from).and_return("1234567890")
    message.stub(:body).and_return("tecnico123")

    tecnico = Registrator.new.register_by_number(message)

    expect(tecnico.class).to eq(Tecnico)
    expect(Tecnico.count).to eq(1)
  end

end

