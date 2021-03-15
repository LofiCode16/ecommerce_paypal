class OrderItemsController < ApplicationController

    def index
        @order = Order.find_by(user_id: current_user.id, payed: false)
        @order_items = @order.order_items unless @order.nil?
    end

    def create
        @order = Order.find_or_create_by(user_id: current_user.id, payed: false)
        @product = Product.find(params[:product_id])
        @order_item = OrderItem.find_or_create_by(order_id: @order.id, product_id: @product.id)

        if @order_item.quantity.nil?
            @order_item.update(quantity: 1, total: @product.price)
        else
            @order_item.update(quantity: @order_item.quantity + 1, total: @product.price * (@order_item.quantity + 1))
        end

        redirect_to root_path, notice: 'producto añadido al carro'
    end

    
end