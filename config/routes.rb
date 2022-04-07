# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#landing'
  get '/register', to: 'users#new', as: 'new_user'
  get '/login', to: 'users#login_form', as: 'login_form'
  post '/login', to: 'users#login_user', as: 'login_user'
  get '/users/movies/:id', to: 'movies#show'
  get '/dashboard', to: 'users#show'
  resources :discover, only: [:index]
  resources :users, only: [:create] do
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create]
    end
  end 
end
