Rails.application.routes.draw do
  resources :posts
  resources :stops
  root to: 'home#index'
end
