Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'sessions/create'
  post 'posts/viewed-post', to: 'posts#viewed_post'
  resources :thoughts, path: "send-your-love"
  resources :posts
  resources :stops, path: "journal"
  resources :registry, only: [:index]
  resources :emails, only: [:create]
  root to: 'home#index'
end
