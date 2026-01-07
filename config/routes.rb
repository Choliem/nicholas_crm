Rails.application.routes.draw do
  root "static_pages#home"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
get 'signup', to: 'users#new'
post 'users', to: 'users#create'
  resources :users, only: [:create]

  resources :leads
  resources :products
  resources :projects do
    member { patch :approve }
  end
end