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
    resources :rules
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

  post '/houses/:house_id/communal_items/:communal_item_id/issue' => 'issues#item_issue_create'
  post '/houses/:house_id/rules/:rule_id/issue' => 'issues#rule_issue_create'
  post '/houses/:house_id/events/:event_id/issue' => 'issues#event_issue_create'
  post '/houses/:house_id/chores/:chore_id/issue' => 'issues#chore_issue_create'


  get '/houses/search/:keyword' => 'houses#search'

  post '/chores/:id/promise' => "user_promises#chore_promise_create"
  post '/chores/:id/promise/update' => "user_promises#chore_promise_update"

  delete '/houses/:house_id/communal_items/:communal_item_id/issues/:id' => 'issues#item_issue_delete'
  delete '/houses/:house_id/rules/:rule_id/issues/:id' => 'issues#rule_issue_delete'
  delete '/houses/:house_id/events/:event_id/issues/:id' => 'issues#event_issue_delete'
  delete '/houses/:house_id/chores/:chore_id/issues/:id' => 'issues#chore_issue_delete'

  get "/houses/:id/bills" => "bills#index"

end
