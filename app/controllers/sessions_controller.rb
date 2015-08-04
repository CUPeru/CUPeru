class SessionsController < ApplicationController
  def create
    redirect_to "welcome#show"
  end

  def new
  end
end
