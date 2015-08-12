class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :find_healthcare_worker

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def find_healthcare_worker(message)
    case message.messageable_type
    when "Agent"
      agent_path(Agent.find(message.messageable_id))
    when "Tecnico"
      tecnico_path(Tecnico.find(message.messageable_id))
    end
  end
end
