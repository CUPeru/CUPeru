require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  before_action :create_client
  skip_before_action :verify_authenticity_token

  def text
    @account = @client.account
    user_messages = @account.messages.list.map {|m| m if m.from != "+12674227124"}
    sorted_messages = user_messages.compact.sort_by {|m| m.date_created}
    your_message = sorted_messages.last
    final = "You just sent: " + your_message.body + ", and your phone number is: " + your_message.from

    response = Twilio::TwiML::Response.new do |r|
      r.Message final
    end
    render_twiml response
  end

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
  end
end


