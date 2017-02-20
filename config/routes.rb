Rails.application.routes.draw do
  get 'users/index'
  get 'dummy' => 'auth#dummy'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'
end
