require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

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
