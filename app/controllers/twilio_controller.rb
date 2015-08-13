require 'twilio-ruby'
require 'date'
require_relative '../poro/poros.rb'

class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  before_action :create_client
  skip_before_action :verify_authenticity_token

  def text
    MessageHandler.new.route_message(your_message)
    response = Twilio::TwiML::Response.new do |r|
      r.Message "You just sent: #{your_message.body}, and your phone number is: #{your_message.from}"
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

  def your_message
    user_messages = @account.messages.list.reject { |sms| sms.from == "+12674227124"}
    user_messages.compact.group_by { |sms| Date.parse(sms.date_created) }.first[1].first
  end

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end
end
