# frozen_string_literal: true

# This file tells the Rails server how incoming requests are sent to which
# controller and method.
#
#
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get '/locations/nj', to: "njs#index"
  get '/locations/nj/new', to: "njs#new"
  get '/locations/nj', to: "njs#create"
  get '/locations/nj/:id', to: "njs#show"
  get '/locations/nj/:id/edit', to: "njs#edit"
  get '/locations/nj/:id', to: "njs#update"
  get '/locations/nj/:id', to: "njs#destroy"

  resources :njs, path: 'locations/nj'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 
  root 'home#index'
  get '/profile/:id', to: "profile#index"
 
  # Devise authentification pages. This controlls the user login
  # and authentification system.
  devise_for :users

  

  # Examples:
  #
  # # Add app CRUD operations from a controller. Used with scaffolding.
  # # CRUD -> create (API/POST), new (page/GET), index, show,
  #           edit(page/GET), update(API/PATCH|PUT), destroy(API/DELETE)
  # resources :my_controller
  #
  # # Add GET path for photos controller, index method
  # get 'photos/index'
  #
  # # Resources, but only register these methods
  # resources :photos, only: [:index, :new, :create, :destroy]
  #
  # # Add PUT path for the given url, but send it to a different controller
  # # than rails would assume by the name. to: 'controller#method_name'.
  # # It would have extected to: 'add_tags#add', which would fail
  # put '/add_tags/add', to: 'users#add_tags'
end
