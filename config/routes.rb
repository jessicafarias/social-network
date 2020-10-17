Rails.application.routes.draw do
  resources :followings, only: [:index, :create, :destroy, :update, :new]
  resources :opinions, only: [:index, :create, :destroy, :edit, :show, :update, :new]
  resources :users, only: [:index, :create, :destroy, :edit, :show, :update, :new]
  resources :user_sessions, only: [:new, :create, :destroy, :new]
  root to: 'opinions#index'

  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  get '/follow/:list', to: 'users#index'
  get '/startfollow/:id', to: 'followings#create'

end
