Rails.application.routes.draw do
  # resources :users
  root to: 'profile#index'
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  
  resources :users, only: [:new, :create]
end
