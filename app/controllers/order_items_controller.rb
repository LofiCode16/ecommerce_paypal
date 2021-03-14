class OrderItemsController < ApplicationController

    def show
        @order_items = Order.find_by(user_id: current_user.id, payed: false).order_items
    end
end