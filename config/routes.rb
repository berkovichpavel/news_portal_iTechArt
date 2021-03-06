require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, except: [:create, :new, :destroy] do
    resources :subscriptions, except: [:index, :show]
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
    resources :comments, module: :items, except: [:update, :edit, :show, :index]
    resources :reviews, except: [:index, :show]
  end

  get 'search', to: 'search#search'

  mount Ckeditor::Engine => '/ckeditor'
  mount Sidekiq::Web => '/sidekiq'

  get '*unmatched_route', to: 'application#raise_not_found'
end
