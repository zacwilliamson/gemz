Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :friendships, only: %i[create destroy]
  resources :reactions, only: %i[create destroy]
  resources :users, only: %i[show notifications] do
    member do
      get :friends
      get :notifications
      resources :profiles, only: %i[new create edit update]
    end
  end
  resources :posts, only: %i[create destroy show edit update index] do
    resources :comments, only: %i[create destroy edit]
  end
end
