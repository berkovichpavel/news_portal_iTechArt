Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'items#index'
  get '/items//read_rss' => 'items#read_rss', as: 'items_rss'
  resources :items


  devise_for :users
  # get 'users/profile'
  # get 'users/profile', as: 'user_root'
  resources :users

  resources :items do
    resources :comments
    resources :reviews
  end
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#root 'home#index'
