require 'rails_helper'
require_relative '../../app/poro/parser.rb'

describe Parser do
  it 'parses broadcasts' do
    twilio_message = find_twilio_message("broadcast")
    create_db_message = Message.create(body: twilio_message.body)
    parser = Parser.new.parse_message(twilio_message)

    expect(find_db_message(twilio_message).keyword).to eq("Broadcast")
  end

  it 'parses symptoms' do
    twilio_message = find_twilio_message("symptoms")
    create_db_message = Message.create(body: twilio_message.body)
    parser = Parser.new.parse_message(twilio_message)

    expect(find_db_message(twilio_message).keyword).to eq("Symptom")
  end

  it 'parses unknown commands' do
    twilio_message = find_twilio_message("agent")
    create_db_message = Message.create(body: twilio_message.body)
    parser = Parser.new.parse_message(twilio_message)

    expect(find_db_message(twilio_message).keyword).to eq(nil)
  end

  def find_twilio_message(keyword)
    @client ||= Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @client.account.messages.list.select {|m| m if m.body.include?(keyword)}.first
  end

  def find_db_message(twilio_message)
    Message.find_by(body: twilio_message.body)
  end
end
