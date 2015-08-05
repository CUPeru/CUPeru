require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  before_action :create_client
  skip_before_action :verify_authenticity_token

  def text
    @account = @client.account
    @messages = @account.messages.list
    message = ""
    @messages.map {|m| message = message + "\n" + m.body}
    byebug
    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render_twiml response
  end

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
  end
end


