Rails.application.routes.draw do
  get 'mypage/index'
  resources :users
  resources :apikeys

  get 'search/index'
  post 'search/search'

  get 'manage_console/index'

  get 'welcome/index'

  root 'welcome#index'

end
