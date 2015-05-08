Rails.application.routes.draw do


  get    '/'  => 'users#welcome'
  get    'signup'  => 'users#new'
  post   'users'   => 'users#create'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get     "/houses/:id/roommates" => 'houses#roommates'
  get     "/request_login" => "users#request_login"

  delete  'notifications/:id' => 'notifications#destroy'
  delete  'houses/:house_id/notifications/all' => 'notifications#destroy'

  resources :users do
    resources :notifications, only: [:index]
  end

  get '/houses/:id/roommates', to: 'users#index'


  resources :houses do
    resources :property_managers
    resources :messages
    resources :rules, except: [:edit] do
      resources :issues, only: [:create, :destroy]
    end
    resources :communal_items
    resources :events
    resources :chores, shallow: true do
      resources :chore_logs, only: [:create, :show, :destroy]
    end
  end

  get '/houses/:id/roommates', to: 'users#index'

  get '/houses/:id/join' => 'houses#join'
  post '/houses/:id/join' => 'houses#join_update'


  post '/houses/:house_id/communal_items/:id/high' => 'communal_items#high'
  post '/houses/:house_id/communal_items/:id/low' => 'communal_items#low'
  post '/houses/:house_id/communal_items/:id/out' => 'communal_items#out'

  post '/houses/:house_id/communal_items/:communal_item_id/promise' => 'user_promises#create'
  post '/houses/:house_id/communal_items/:communal_item_id/promise_fulfilled' => 'user_promises#update'

  get '/houses/search/:keyword' => 'houses#search'

  post '/chores/:id/promise' => "user_promises#chore_promise_create"
  post '/chores/:id/promise/update' => "user_promises#chore_promise_update"

  get "/houses/:id/bills" => "bills#index"

end
