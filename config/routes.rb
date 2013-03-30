DynamicTicketingSystem::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"

  get "create_account" => "users#new", :as => "create_account"
  root :to => "users#new"

  resources :users
  resources :sessions
end
