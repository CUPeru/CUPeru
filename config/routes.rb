Rails.application.routes.draw do
  root to: 'home#show'

  get  '/dashboard',             to: 'dashboard#show'
  get  '/export_all',            to: 'dashboard#export_all'
  post '/twilio/create',         to: 'twilio#create'
  get  '/logout',                to: 'sessions#destroy'
  get  '/auth/twitter/callback', to: 'sessions#create'
  get  '/agents/:id',            to: 'agents#show',     as: 'agent'
  get  '/tecnicos/:id',          to: 'tecnicos#show',   as: 'tecnico'
end
