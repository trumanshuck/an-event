Rails.application.routes.draw do
  resources :posts
  resources :stops
  resources :registry
  root to: 'home#index'
end
