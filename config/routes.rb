Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :items


  devise_for :users
  # resources :users
  get 'users/profile'
  get 'users/profile', as: 'user_root'

  root to: 'items#index'
  namespace :admin do

  end

  resources :items do
    resources :comments
  end
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#root 'home#index'
