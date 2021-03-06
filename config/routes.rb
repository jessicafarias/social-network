Rails.application.routes.draw do
  resources :followings, only: [:create, :destroy, :new]
  resources :opinions, except: %i[:destroy]
  resources :users, except: %i[:destroy, :edit]
  resources :user_sessions, only: [:new, :create, :destroy]
  root to: 'opinions#index'

  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  get '/follow/:list', to: 'users#index'
  get '/talkey/:list', to: 'opinions#index'
  get '/startfollow/:id', to: 'followings#create'

end
