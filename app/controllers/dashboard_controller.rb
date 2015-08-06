class DashboardController < ApplicationController
  def show
    @messages = Message.all
  end
end

