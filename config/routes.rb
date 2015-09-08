Rails.application.routes.draw do

  root 'products#index'

  resources :users, only: [:new, :create]
  resources :products

  resources :sessions, only: [:new, :create, :destroy]

end
