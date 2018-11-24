Rails.application.routes.draw do
  get 'top/index'
  resources :users
  resources :apikeys

  get 'search/index'
  post 'search/search'

  get 'mypage/index'

  get 'manage_console/index'

  get 'welcome/index'

  root 'welcome#index'

end
