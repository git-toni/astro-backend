Rails.application.routes.draw do
  resources :telescopes
  resources :posts
  #get 'users/index'
  get 'users/:id/profile', to:'users#profile', as: 'user_profile'
  get 'users/:id/settings', to:'users#settings', as: 'user_settings'
  get 'dummy' => 'auth#dummy'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'
  match '*any', via: :all, to: 'errors#not_found'
  #match '*foo', via: :all, :format => true, :constraints => {:format => :json}, :to => lambda {|env| [404, {}, ['{"error": "not_found"}']] }
end
