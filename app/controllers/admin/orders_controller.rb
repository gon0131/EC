class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details =@order.order_details
    @total = 0
  end

  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.order_details.update_all(order_status: 1) if @order.order_status_i18n == "入金確認"
      redirect_to admin_orders_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
