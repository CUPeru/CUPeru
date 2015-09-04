require 'rails_helper'

feature 'Application sends text' do
  let(:message)   { Message.new(to: app_phone, from: sender, body: body) }
  let(:app_phone) { ENV['twilio_phone_number'] }
  let(:sender)    { '+14444444444' }
  let(:body)      { 'help register' }
  let(:client)    { double('twilio').as_null_object }

  before do
    stub_const('TwilioClient', client)
    allow(client).to receive(:send_text)
  end

  scenario 'help text' do
    Dispatcher.route(message)
    expect(TwilioClient).to have_received(:send_text)
  end

  scenario 'help text' do
    Dispatcher.route(message)
    expect(TwilioClient).to have_received(:send_text)
  end

end
