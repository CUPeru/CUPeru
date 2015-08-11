require 'ostruct'
require 'rails_helper'
require_relative '../../app/poro/parser.rb'

describe Parser do
  it 'parses broadcasts' do
    message = double()
    message.stub(:body).and_return("broadcast")
    message.stub(:from).and_return("1234567890")
    parser = Parser.new(message).parse_message

    expect(parser.class).to eq(Broadcast)
  end

  xit 'parses emergencies' do
    message = double()
    message.stub(:body).and_return("emergency")
    parser = Parser.new(message).parse_message

    expect(parser.class).to eq(Emergency)
  end

  it 'parses symptoms' do
    message = double()
    message.stub(:body).and_return("symptoms")
    parser = Parser.new(message).parse_message

    expect(parser.class).to eq(Symptom)
  end

  it 'parses unknown commands' do
    message = double()
    message.stub(:body).and_return("this is a weird text")
    message.stub(:from).and_return("1234567890")
    parser = Parser.new(message).parse_message

    expect(parser).to eq("I dunno what to do with this message")
  end
end
