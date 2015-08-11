require 'rails_helper'
require_relative '../../app/poro/broadcast'

describe Broadcast do
  it 'finds the correct health center' do
    broadcast = Broadcast.new
    health_center = HealthCenter.create(phone_number: "+15555555555")
    message = OpenStruct.new(:from => "+15555555555")
    broadcast.send(:find_health_center_by_message, message)

    expect(broadcast.health_center).to eq(health_center)
  end

  it 'it creates the client' do
    broadcast = Broadcast.new
    account = broadcast.send(:create_client)

    expect(account.class).to eq(Twilio::REST::Account)
  end

  it 'finds all the posts agents' do
    broadcast = Broadcast.new
    health_center = HealthCenter.create(phone_number: "+15555555555")
    health_post = health_center.health_posts.create(phone_number: "+15555555555")
    agent = health_post.agents.create(phone_number: "+12154106125")

    broadcast.instance_variable_set("@health_center", health_center)
    agents = broadcast.send(:agents)

    expect(agents.first.class).to eq(Agent)
    expect(agents.first.phone_number).to eq("+12154106125")
  end
end


