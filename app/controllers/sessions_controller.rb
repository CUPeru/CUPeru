class SessionsController < ApplicationController
  def create
    redirect_to "home#show"
  end

  def new
  end
end
