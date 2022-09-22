class Customer::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items.all
    if @cart_items.empty?
      redirect_to cart_items_path
    end
  end

  def confirm
    @cart_items = current_customer.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path
    end
    @total = 0
    if  params[:order][:address_option] == "0"
      @order = Order.new(order_params)
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.recipient_name = current_customer.first_name + current_customer.last_name
      @order.postage = 800
    elsif params[:order][:address_option] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.recipient_name = @address.name
      @order.postage = 800
    elsif params[:order][:address_option] == "2"
      @order = Order.new(order_params)
      @order.postage = 800
    end
  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path
    end
    @order = Order.new(order_params)
    @order.save
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price
      @order_detail.item_id = cart_item.item.id
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :recipient_name, :postage, :payment_amount, :customer_id)
  end
end
