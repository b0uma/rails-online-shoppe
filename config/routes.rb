Rails.application.routes.draw do
  root 'products#index'
  resources :products
  get '/admin', to: 'products#admin'
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
