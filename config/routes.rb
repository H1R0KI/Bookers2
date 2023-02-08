Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :books, only: [:new, :index, :show, :edit]
  resources :usrs, only: [:show, :edit]
end
