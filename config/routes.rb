Rails.application.routes.draw do
  root :to => 'brands#index'
  resources :brands
  resources :items, :except => [:show]
  resources :outfits

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
  post '/follow/:id' => 'users#follow'
  delete '/follow/:id' => 'users#unfollow'
  resources :users, :path => '/u' do
    resources :items, :except => [:new,:edit,:create,:update,:destroy]
    resources :outfits, :except => [:index,:new,:edit]
  end
end
