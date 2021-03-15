Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products

  # resource :order_items, only: [:show, :update] do
  #   member do
  #     post :pay_with_paypal
  #     get :process_paypal_payment
  #   end
  # end

  post 'order_items/pay_with_paypal', to: 'order_items#pay_with_paypal', as: 'pay_with_paypal_order_items'
  get 'order_items/process_paypal_payment', to: 'order_items#process_paypal_payment', as: 'process_paypal_payment_order_items'

  get 'cart', to: 'order_items#index', as: 'cart'
  post 'cart/:product_id/add', to: 'order_items#create', as: 'cart_add'
  delete 'cart/:item_id/remove', to: 'order_items#destroy', as: 'destroy_cart_item'

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
