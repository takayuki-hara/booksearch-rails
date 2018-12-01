Rails.application.routes.draw do
  resources :release_watches
  resources :users
  resources :keywords
  resources :favorites
  resources :apikeys

  get 'search/index'
  post 'search/search'

  get 'mypage/index'

  get 'manage_console/index'

  get 'top/index'

  root 'top#index'

end
