Rails.application.routes.draw do
  # Root route
  root to: "dashboard#show"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication routes
  get "login", to: "sessions#new", as: :new_session
  post "login", to: "sessions#create", as: :session
  delete "logout", to: "sessions#destroy", as: :logout  # Changed from :destroy_session

  # User profile routes
  get "profile/edit", to: "users#edit", as: :edit_profile
  patch "profile", to: "users#update", as: :update_profile

  # Registration routes
  get "signup", to: "users#new", as: :signup
  post "signup", to: "users#create"

  # Resources
  resources :posts
  resources :passwords, param: :token

  # Friends system
  resources :friends, only: [ :index ]
  resources :friendships, only: [ :create, :update, :destroy ]
  get "friend_requests", to: "friendships#index", as: :friend_requests

  resources :users do
    post "friendships", to: "friendships#create"
  end

  # PWA routes (commented out)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
