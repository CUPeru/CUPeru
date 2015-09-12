class DashboardController < ApplicationController
  def show
    @messages = Message.recent
  end

  private

  def export_all
    Exporter.run
  end
end
