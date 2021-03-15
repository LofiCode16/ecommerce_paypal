Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products

  get 'cart', to: 'order_items#index', as: 'cart'
  post 'cart/:product_id/add', to: 'order_items#create', as: 'cart_add'

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
