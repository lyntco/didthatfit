Rails.application.routes.draw do
  root :to => 'brands#index'
  resources :categories, :only => [:index,:show] do
    resources :types, :only => [:index,:show]
  end
  resources :brands
  resources :users, :only => [:index]
  resources :items
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
  get '/profile' => 'users#show'
  resources :users, :path => '/' do
    resources :items, :except => [:index]
    resources :outfits, :except => [:index]
  end
end
