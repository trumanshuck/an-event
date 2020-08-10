Rails.application.routes.draw do
  resources :stops
  root to: 'home#index'
end
