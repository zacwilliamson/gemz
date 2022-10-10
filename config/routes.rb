Rails.application.routes.draw do
  root 'static_pages#home'
  
  devise_for :users
  resources :users, only: [:show] do
    member do
      get :friends
    end
  end
end
