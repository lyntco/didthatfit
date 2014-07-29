Rails.application.routes.draw do
  root :to => 'items#following'
  resources :brands
  resources :items, :except => [:show]
  resources :outfits, :except => [:show,:create,:index,:edit,:update,:destroy]

  resources :users, :path => '/u' do
    # get :follow
    resources :items, :except => [:new,:edit,:create,:update,:destroy]
    resources :outfits, :except => [:new,:edit,:create,:update,:destroy]
  end
  post '/u/:id/edit' => 'users#make_admin' # can move into users block
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'
  post '/follow/:id' => 'users#follow'
  delete '/follow/:id' => 'users#unfollow'
  get '/search' => 'pages#search'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

  get '/oauth/connect' => 'sessions#instagram'
  get '/oauth/callback' => 'sessions#instagram_callback'

end
