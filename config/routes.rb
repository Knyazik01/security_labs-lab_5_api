Rails.application.routes.draw do
  # sessions
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # user
  # resources :users, only: [:show, :create, :update, :destroy]
  # resources :users, only: [:show]
  get '/me', to: 'users#show'
  post '/registration', to: 'users#create'
end
