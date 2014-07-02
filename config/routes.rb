Rails.application.routes.draw do
  # root :to => 'brands#index'
  root :to => 'items#following'
  resources :brands
  resources :items, :except => [:show]
  resources :outfits, :except => [:show]
  resources :type
  resources :category

  resources :users, :path => '/u' do
    resources :items, :except => [:new,:edit,:create,:update,:destroy]
    resources :outfits, :except => [:new,:edit,:create,:update,:destroy]
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
  post '/follow/:id' => 'users#follow'
  delete '/follow/:id' => 'users#unfollow'
  get '/search' => 'pages#search'

  match 'auth/:provider/callback', to: 'sessions#fb_create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
