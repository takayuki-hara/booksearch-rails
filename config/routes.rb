Rails.application.routes.draw do
  resources :users
  resources :keywords
  resources :favorites
  resources :release_watches

  resources :apikeys

  get 'search/index'
  get 'search' => 'search#search'
  post 'search' => 'search#search'

  get 'mypage/index'

  get 'manage_console/index'

  get 'top/index'

  root 'top#index'

end
