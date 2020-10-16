Rails.application.routes.draw do
  resources :followings
  resources :opinions
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]
  root to: 'opinions#index'

  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  get '/follow/:list', to: 'users#index'
  get '/startfollow/:id', to: 'followings#create'

end
