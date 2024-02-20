class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
    @delivery_destinations = current_customer.delivery_destinations.all
  end

  def confirm
    @order = current_customer.orders.new(order_params)

    @cart_items = current_customer.cart_items.all
    @order.postage = 800

    if params[:order][:adress_type] == "0"
      @order.postal_code = current_customer.postal_code
      @order.adress = current_customer.adress
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:adress_type] == "1"
      delivery_destination = DeliveryDestination.find(params[:order][:adress_id])
      @order.postal_code = delivery_destination.postal_code
      @order.adress = delivery_destination.adress
      @order.name = delivery_destination.name
    elsif params[:order][:adress_type] = "2"
      @order.postal_code = params[:order][:postal_code]
      @order.adress = params[:order][:adress]
      @order.name = params[:order][:name]
    end
      if @order.invalid? == true
         @order = current_customer.orders.new(order_params)
        render :new
      end



  end

  def create
    @order = Order.new(order_params)
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail =  OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.tax_included_price = cart_item.subtotal
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to order_thanks_path
  end

  def thanks

  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(7)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details

  end


  private
    def order_params
        params.require(:order).permit(:customer_id, :payment_method, :billing_amount, :name, :postal_code, :adress, :postage, :status)
    end

end
