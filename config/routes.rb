Rails.application.routes.draw do
  root                          to: 'home#show'
  post 'twilio/voice',          to: 'twilio#voice'
  post '/twilio/text',          to: 'twilio#text'
  post 'twilio/send_text',      to: 'twilio#send_text'
  get '/auth/twitter',          as: '/login', to: 'sessions#new'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout',                to: 'sessions#destroy'
  get '/dashboard',             to: 'dashboard#show'
end
