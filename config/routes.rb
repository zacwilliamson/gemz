Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  resources :friendships, only: %i[create destroy]
  resources :posts, only: %i[create destroy show edit]
  resources :users, only: %i[show notifications] do
    member do
      get :friends
      get :notifications
    end
  end
end
