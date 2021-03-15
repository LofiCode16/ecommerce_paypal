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

        @order.update(total: @order.order_items.pluck(:total).sum)

        redirect_to root_path, notice: 'producto añadido al carro'
    end

    def destroy
        @item = OrderItem.find(params[:item_id])

        @item.order.update(total: @item.order.total - @item.total)
        @item.destroy

        redirect_to cart_path, notice: 'producto quitado del carro'
    end 
end