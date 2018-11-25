Rails.application.routes.draw do
  resources :users
  resources :apikeys

  get 'search/index'
  post 'search/search'

  get 'mypage/index'

  get 'manage_console/index'

  get 'top/index'

  root 'top#index'

end
