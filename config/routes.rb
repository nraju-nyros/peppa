Rails.application.routes.draw do

  devise_for :users, :controllers =>{
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  devise_for :admin, :controllers =>{
    :registrations => 'admin/registrations',
    :sessions => 'admin/sessions',
    :passwords => 'admin/passwords',
    :confirmations => 'admin/confirmations',
    :unlocks => 'admin/unlocks',
  }

  root "home#index"

  resources :admin ,:only => [:index]

  #Admin panel Dishes enter through restaurants
  namespace :admin do
    resources :restaurants do
      resources :dishes do
        resources :ratings
      end
    end
    resources :locations
  end


  resources :home
  resources :restaurants
  resources :dishes
  resources :pictures
  resources :dishes_restaurants
  resources :locations_restaurants
  resources :contacts
  resources :ratings
 
 
  # search method from homepage
  get '/search' => 'home#search', :as => 'search_page'


  resources :dishes do
    resources :likes
  end


  

end
