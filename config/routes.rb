Rails.application.routes.draw do
  # if @current_user.present?
    # root :to => 'users#show'
  # else
    root :to => 'brands#index'
  # end
  # resources :categories, :only => [:index,:show] do
  #   resources :types, :only => [:index,:show]
  # end
  resources :brands
  resources :users, :only => [:index]
  resources :items
  resources :outfits

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'

  resources :users, :path => '/u' do
    resources :items, :except => [:index,:new,:edit]
    resources :outfits, :except => [:index,:new,:edit]
  end
end
