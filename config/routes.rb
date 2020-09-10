Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'sessions/create'
  resources :thoughts
  resources :posts
  resources :stops, path: "journal"
  resources :registry, only: [:index]
  root to: 'home#index'
end
