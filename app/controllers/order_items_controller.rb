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

    def pay_with_paypal
        order = Order.find(params[:order_id])

        response = EXPRESS_GATEWAY.setup_purchase(
            order.total * 100,
            ip: request.remote_ip,
            return_url: process_paypal_payment_order_items_url,
            cancel_return_url: root_url,
            allow_guest_checkout: true,
            currency: "USD"
        )

        payment_method = PaymentMethod.find_by(code: 'PEC')

        Payment.create(
            order_id: order.id,
            payment_method_id: payment_method.id,
            state: 'processing',
            total: order.total,
            token: response.token
        )

        redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    end

    def process_paypal_payment
        details = EXPRESS_GATEWAY.details_for(params[:token])

        express_purchase_options = {
            ip: request.remote_ip,
            token: params[:token],
            payer_id: details.payer_id,
            currency: 'USD'
        }

        price = details.params["order_total"].to_d * 100

        response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)

        if response.success?
            payment = Payment.find_by(token: response.token)
            order = payment.order
            order.update(payed: true)

            ActiveRecord::Base.transaction do
                order.save!
                payment.save!
            end

            redirect_to root_path, notice: 'Compra finalizada con exito'

        else
            redirect_to root_path, alert: 'la compra ha fallado'
        end

    end
end