Rails.application.routes.draw do
  post 'twilio/voice' => 'twilio#voice'
  root to: "sessions#new"
  get '/login', to: "home#show"
end
