Rails.application.routes.draw do
  root                          to: 'home#show'
  get '/dashboard',             to: 'dashboard#show'
  post 'twilio/voice',          to: 'twilio#voice'
  post '/twilio/text',          to: 'twilio#text'
  post 'twilio/send_text',      to: 'twilio#send_text'
  get '/logout',                to: 'sessions#destroy'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/twitter',          as: '/login',          to: 'sessions#new'
  get '/agents/:id',            as: 'agent',          to: 'agents#show'
  get '/tecnicos/:id',          as: 'tecnico',        to: 'tecnicos#show'
end
