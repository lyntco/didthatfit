Rails.application.routes.draw do
  root :to => 'brands#index'
  # resources :users do
  #   resources :items
  # end
  # resources :categories do
  #   resources :types
  # end
  # resources :brands
  resources :users
  resources :items
  resources :categories, :only => [:index,:show]
  resources :types, :only => [:index,:show]
  resources :brands
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
end
