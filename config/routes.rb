Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'sessions/create'
  resources :thoughts
  resources :posts
  resources :stops
  resources :registry, only: [:index]
  root to: 'home#index'
end
