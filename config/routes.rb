require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users

  resources :users do
    resources :subscriptions
    resources :statistics
    member do
      get 'comments_activity'
      get 'items_activity'
    end
  end

  resources :rss_subscriptions

  resources :items do
    member do
      post 'track'
    end
    resources :comments, module: :items
    resources :reviews
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount Sidekiq::Web => '/sidekiq'
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# root 'home#index'
