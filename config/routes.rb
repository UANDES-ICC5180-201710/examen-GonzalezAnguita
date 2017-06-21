Rails.application.routes.draw do
  
  devise_for :users
  
  resources :users do
    get 'is_staff', on: :member
  end
  resources :games do
    get 'user_purchased', on: :member
  end
  
  root to: 'games#index'
end
