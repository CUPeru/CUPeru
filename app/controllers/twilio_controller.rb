# TODO: (dysnomian) Move to decent_exposure in controllers like this one
class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header
  skip_before_action :verify_authenticity_token

  def create
    message = Message.create(
                from: ENV['twilio_phone_number'],
                to:   params[:to],
                body: params[:body])
    if message
      TwilioClient.send_text(message.to_text)

      # TODO: (dysnomian) Localize these messages.
      flash[:notice] = "Message sent to #{message.to}!"
      redirect_to dashboard_path
    else
      flash[:notice] = "There was an error sending your message."
      redirect_to dashboard_path
    end
  end
end
