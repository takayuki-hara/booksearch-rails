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
      get 'users/me'
      post 'users/login'
    end
  end
end
