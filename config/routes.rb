Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root to: 'items#index'

  # get 'users/profile'
  # get 'users/profile', as: 'user_root'
  devise_for :users

  resources :users do
    resources :subscriptions
  end

  resources :items do
    resources :comments, module: :items
    resources :reviews
  end
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#root 'home#index'
