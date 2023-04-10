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
  patch '/add-to-e-wallet/:e_wallet_id', to: 'e_wallets#add_funds'

  # products
  get '/products-bought', to: 'products#users_bought'
  get '/products-can-buy', to: 'products#user_can_buy'
  get '/product-download/:product_id', to: 'products#download_file'

  # purchases
  post '/product-buy/:product_id', to: 'purchases#create'
end
