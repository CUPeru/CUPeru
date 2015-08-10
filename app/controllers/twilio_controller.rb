require 'twilio-ruby'
require 'date'
require_relative '../poro/poros.rb'

class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  before_action :create_client
  skip_before_action :verify_authenticity_token

  def text
    user_messages = @account.messages.list.reject { |sms| sms.from == "+12674227124"}
    your_message = user_messages.compact.group_by { |sms| Date.parse(sms.date_created) }.first[1].first
    final = "You just sent: #{your_message.body}, and your phone number is: #{your_message.from}"
    Registrator.new(your_message)
    Parser.new(your_message)
    save_message(your_message)
    # TODO:
    # if an agent/tecnico exists already, send the message to a PORO for parsing/routing.
    # this PORO will have methods for each keyword, as well as a route to a PORO for the medical API
    # also - only me, michael, allison, and CUPeru can login through twitter
    #
    # OPTIIONAL: translate all outgoing texts to spanish
    # d3 graph of texts
    # calculate total twilio cost and show balance
    # profile pages for users, messages, etc (linked to on admin dashboard)
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
    Message.create(
      body: message.body,
      to: message.to,
      from: message.from,
      date_sent: message.date_created
    )
  end
end


