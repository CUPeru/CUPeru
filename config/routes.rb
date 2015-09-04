Rails.application.routes.draw do
  root to: 'home#show'

  get  '/dashboard',             to: 'dashboard#show'
  post 'twilio/voice',           to: 'twilio#voice'
  post '/twilio/create',         to: 'twilio#create'
  post 'twilio/send_text',       to: 'twilio#send_text'
  get  '/logout',                to: 'sessions#destroy'
  get  '/auth/twitter/callback', to: 'sessions#create'
  get  '/agents/:id',            to: 'agents#show',     as: 'agent'
  get  '/tecnicos/:id',          to: 'tecnicos#show',   as: 'tecnico'
end
