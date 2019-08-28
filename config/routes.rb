Rails.application.routes.draw do
  root to: 'users#index'
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :users
  resources :profiles
  
  # resources :users
end
