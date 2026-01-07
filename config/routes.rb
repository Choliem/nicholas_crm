Rails.application.routes.draw do
  # Halaman utama: Daftar Prospek (Leads)
  root "leads#index"

  # Jalur untuk Autentikasi
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Resource standar yang sudah kita buat tadi
  resources :projects
  resources :products
  resources :leads
  resources :users
end