class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header
  skip_before_action :verify_authenticity_token

  def create
    message = Message.create(
                from: params[:from],
                to:   params[:to],
                body: params[:body])
    Dispatcher.route(message)

    render json: message, status: 201
  end
end
