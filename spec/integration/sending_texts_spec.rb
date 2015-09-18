require 'rails_helper'

feature 'Application receives help text' do
  let(:app_phone) { ENV['twilio_phone_number'] }
  let(:sender)    { '+14444444444' }
  let(:body)      { 'help register' }

  let(:client)    { double('twilio').as_null_object }
  let(:twilio_message) do
    double('twilio_message',
           to: app_phone,
           from: sender,
           body: body,
           status: :delivered,
           sid: 1).as_null_object
  end

  before do
    stub_const('TwilioClient', client)
    allow(client).to receive(:incoming_messages).and_return([twilio_message])
    allow(client).to receive(:send_text)
    allow(twilio_message).to receive(:delete)
  end

  scenario 'help text' do
    IncomingMessagesWorker.new.perform
    expect(client).to have_received(:fetch_incoming_messages)
  end
end
