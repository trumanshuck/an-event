Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'sessions/create'
  resources :thoughts, path: "send-your-love"
  resources :posts
  resources :stops, path: "journal"
  resources :registry, only: [:index]
  root to: 'home#index'
end
