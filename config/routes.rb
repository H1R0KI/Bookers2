Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: [:create, :index, :show, :edit, :destroy, :update] do
    resource :post_comments, only: [:create]
  end
  resources :users, only: [:index, :show, :edit, :update]
  
  post "favorite/:id" => "favorites#create", as: "create_favorite"
  delete "favorite/:id" => "favorites#destroy", as: "destroy_favorite"
end
