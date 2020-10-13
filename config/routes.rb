Rails.application.routes.draw do
  resources :followings
  resources :opinions
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]

  
  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'
end
