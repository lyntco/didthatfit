Rails.application.routes.draw do
  root :to => 'brands#index'
  resources :users do
    resources :items, :only => [:index,:show]
  end
  resources :categories, :only => [:index,:show] do
    resources :types, :only => [:index,:show]
  end
  resources :brands
  resources :users, :except => [:index,:show]
  resources :items
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
end
