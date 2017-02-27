Rails.application.routes.draw do
  resources :telescopes
  resources :posts
  #get 'users/index'
  get 'users/:id/profile', to:'users#profile', as: 'user_profile'
  get 'dummy' => 'auth#dummy'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'
end
