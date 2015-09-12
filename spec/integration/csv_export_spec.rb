require 'rails_helper'

feature 'CSV export' do
  scenario 'all messages' do
    given_incoming_messages
    given_outgoing_messages
    when_i_am_logged_in_as_an_admin
    when_i_use_the_csv_export_action
    then_i_get_a_full_csv
  end
end

def given_outgoing_messages
  Message.create(to: '15554443333', from: ENV['twilio_phone_number'], body: "1")
  Message.create(to: '15554443333', from: ENV['twilio_phone_number'], body: "2")
  Message.create(to: '15554443333', from: ENV['twilio_phone_number'], body: "3")
end

def given_incoming_messages
  Message.create(to: ENV['twilio_phone_number'], from: '15554443333', body: "1")
  Message.create(to: ENV['twilio_phone_number'], from: '15554443333', body: "2")
  Message.create(to: ENV['twilio_phone_number'], from: '15554443333', body: "3")
end

def when_i_am_logged_in_as_an_admin

end

def when_i_use_the_csv_export_action

end

def then_i_get_a_full_csv

end
