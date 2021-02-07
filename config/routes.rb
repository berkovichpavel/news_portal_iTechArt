require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, except: [:create, :new, :destroy] do
    resources :subscriptions
    resources :statistics, except: [:index, :show, :edit, :destroy, :update]
    member do
      get 'comments_activity'
      get 'items_activity'
    end
  end

  resources :rss_subscriptions, except: [:show, :edit, :update]

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
