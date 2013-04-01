DynamicTicketingSystem::Application.routes.draw do

  get "profile" => "sessions#view", :as => "profile"
  get "log_in" => "sessions#new", :as => "log_in"

  get "create_account" => "users#new", :as => "create_account"
  root :to => "sessions#new"

  resources :users
  resources :sessions
end
