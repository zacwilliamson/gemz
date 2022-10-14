Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  resources :friendships, only: %i[create destroy]
  # resources :notifications, only: %i[index]
  resources :users, only: [:show] do
    member do
      get :friends
      get :notifications
    end
  end
end
