Rails.application.routes.draw do
  resources :users
  resources :keywords
  resources :release_watches

  resources :apikeys

  get 'search/index'
  get 'search/books' => 'search#search'
  post 'search/books' => 'search#search'
  post 'search/favorite'
  post 'search/watch'

  get 'mypage/index'
  get 'favorites' => 'favorites#index'
  delete 'favorites/:id' => 'favorites#destroy', as: 'favorite'

  get 'manage_console/index'

  get 'top/index'

  root 'top#index'

  get 'login/index'
  get 'logout' => 'login#logout'
  post 'login/auth'

  # API
  namespace :api, { format: 'json' } do
    namespace :v1 do
      get 'users' => 'users#index'
      get 'users/me' => 'users#me'
      get 'users/:id' => 'users#show'
      post 'users' => 'users#create'
      put 'users/:id' => 'users#update'
      delete 'users/:id' => 'users#destroy'

      post 'users/login'
      get 'search' => 'search#search'
    end
  end
end
