class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      Order.find(@order_detail.order_id).update(order_status: 2) if @order_detail.order_status_i18n == "製作中"
      Order.find(@order_detail.order_id).update(order_status: 3) if @order_detail.order_status_i18n == "製作完了"
      redirect_to admin_orders_path
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_status)
  end
end