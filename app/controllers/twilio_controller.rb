require 'twilio-ruby'
require 'date'

class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  before_action :create_client
  skip_before_action :verify_authenticity_token

  def text
    user_messages = @account.messages.list.map { |sms| sms if sms.from != "+12674227124"}
    your_message = user_messages.compact.sort_by { |sms| Date.parse(sms.date_created) }.last

    final = "You just sent: " + your_message.body + ", and your phone number is: " + your_message.from

    save_message(your_message)

    response = Twilio::TwiML::Response.new do |r|
      r.Message final
    end
    render_twiml response
  end

  def send_text
    @account.messages.create(
      from: "+12674227124",
      to: params[:to],
      body: params[:body]
    )
    redirect_to '/dashboard'
  end

  private

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end

  def save_message(message)
    Message.create(body: message.body,
                   to: message.to,
                   from: message.from,
                   date_sent: message.date_created)
  end
end


