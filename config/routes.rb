DynamicTicketingSystem::Application.routes.draw do

  get "tickets/new" => "tickets#new"

  #get "tickets#show"

  get "log_out" => "sessions#exit", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  get "create_account" => "users#new", :as => "create_account"
  root :to => "sessions#new"


  resources :users
  resources :sessions

  # Ticket updates as a sub-controller
  #resources :tickets do
  #  resources :ticket_updates
  #end

  resources :tickets do
    #resources :ticket_updates, :controller => 'tickets/ticket_update'
  end
  get 'tickets/:ticket_id/update' => 'tickets/ticket_update#new', :action => 'new'
end
