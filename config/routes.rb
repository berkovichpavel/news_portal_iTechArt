Rails.application.routes.draw do
  get 'items/index'
  get 'items/new', to: 'items#new'
  get 'items/:id', to: 'items#show', constraint: { id: /\d+/ } #constraint not work
  get 'items/:category', to: 'items#category'
  post 'items/create', to: 'items#create'
  get 'items/edit/:id', to: 'items#edit'
  post 'items/update/:id', to: 'items#update'

  devise_for :users
  get 'persons/profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'home#index'
  get 'persons/profile', as: 'user_root'
  root to: 'items#index'
end
