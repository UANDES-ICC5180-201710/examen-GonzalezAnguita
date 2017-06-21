Rails.application.routes.draw do
  
  devise_for :users
  
  resources :users do
    get 'is_staff', on: :member
  end
  resources :games
  
  root to: 'games#index'
end
