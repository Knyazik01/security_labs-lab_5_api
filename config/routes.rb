Rails.application.routes.draw do
  # sessions
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # user
  # resources :users, only: [:show, :create, :update, :destroy]
  get '/me', to: 'users#show'
  post '/registration', to: 'users#create'

  # e_wallets
  get '/e-wallets', to: 'e_wallets#show'
end
