Rails.application.routes.draw do
  # Session and authentication routes
  # resource :session
  get "login", to: "sessions#new", as: :new_session
  post "login", to: "sessions#create", as: :session
  delete "logout", to: "sessions#destroy", as: :logout

  # User registration routes
  get "signup", to: "users#new", as: :signup
  post "signup", to: "users#create"

  # Resources
  resources :posts
  resources :passwords, param: :token

  # Profile routes
  get "profile/edit", to: "users#edit", as: :edit_profile
  patch "profile", to: "users#update", as: :update_profile

  # Friends system routes
  resources :friends, only: [ :index ]
  resources :friendships, only: [ :create, :update, :destroy ]
  get "friend_requests", to: "friendships#index", as: :friend_requests

  resources :users do
    post "friendships", to: "friendships#create"
  end

  # Root route
  root to: "posts#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
