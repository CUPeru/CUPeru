Rails.application.routes.draw do
  root                 to: "sessions#new"
  post 'twilio/voice', to: 'twilio#voice'
  post '/twilio/text',  to: 'twilio#text'
  get '/login',        to: "home#show"
end
