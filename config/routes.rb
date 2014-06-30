Rails.application.routes.draw do
  root :to => 'brands#index'
  resources :users do
    resources :items, :except => [:index]
    resources :outfits, :except => [:index]
  end
  resources :categories, :only => [:index,:show] do
    resources :types, :only => [:index,:show]
  end
  resources :brands
  resources :users, :only => [:index,:show]
  resources :items
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
  get '/profile' => 'users#show'
end
