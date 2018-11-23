Rails.application.routes.draw do
  resources :apikeys

  get 'search/index'

  get 'manage_console/index'

  get 'welcome/index'

  root 'welcome#index'

end
