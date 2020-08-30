Rails.application.routes.draw do
  resources :thoughts
  resources :posts
  resources :stops
  resources :registry, only: [:index]
  root to: 'home#index'
end
