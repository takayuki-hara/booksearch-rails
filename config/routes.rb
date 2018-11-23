Rails.application.routes.draw do
  resources :apikeys
  get 'manage_console/index'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
