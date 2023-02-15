Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
    resources :books, only: [:create, :index, :show, :edit, :destroy, :update]
    resources :users, only: [:index, :show, :edit, :update]
end
