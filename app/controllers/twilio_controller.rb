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
    final = "You just sent: #{your_message.body}, and your phone number is: #{your_message.from}"
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

  def your_message
    user_messages = @account.messages.list.reject { |sms| sms.from == "+12674227124"}
    user_messages.compact.group_by { |sms| Date.parse(sms.date_created) }.first[1].first
  end

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end
end

    # TODO:
    # also - only me, michael, allison, and CUPeru can login through twitter
    # web scraping sypmtoms
    #
    # OPTIIONAL:
    # change login to admin login
    # add more info on homepage
    # translate all outgoing texts to spanish
    # d3 graph of texts
    # calculate total twilio cost and show balance
    # autoforwarding
