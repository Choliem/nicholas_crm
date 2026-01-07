Rails.application.routes.draw do
  root "static_pages#home"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "dashboard", to: "dashboard#index"
  
get 'signup', to: 'users#new'
post 'users', to: 'users#create'
  resources :users, only: [:create]

  resources :leads
  resources :products
  resources :projects do
    member { patch :approve }
    collection { get :customers }
  end

  namespace :admin do
    resources :users, only: [:index, :update]
  end

  resources :sales_targets, only: [:new, :create]
end