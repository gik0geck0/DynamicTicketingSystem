DynamicTicketingSystem::Application.routes.draw do

  get "tickets/new" => "tickets#new"

  #get "tickets#show"

  get "log_out" => "sessions#exit", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  get "create_account" => "users#new", :as => "create_account"
  root :to => "sessions#new"

  resources :users
  resources :sessions
  resources :tickets
end
