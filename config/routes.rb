Rails.application.routes.draw do
  
  devise_for :users
  
  resources :users
  resources :games
  
  root to: 'games#index'
end
