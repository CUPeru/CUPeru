require 'factory_girl'

Agent.delete_all
Message.delete_all

20.times do |i|
  FactoryGirl.create(:incoming_message, :register)
  FactoryGirl.create(:incoming_message)
  FactoryGirl.create(:outgoing_message)
end

Message.all.each do |message|
  Dispatcher.route(message)
end
