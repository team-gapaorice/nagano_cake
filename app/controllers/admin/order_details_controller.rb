class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_details_params)
    if @order_detail.production_status == "in_production"
      @order.update(status: "in_production")
    end
    if @order.order_details.all?{|order_detail| order_detail.production_status == "production_completed"}
      @order.update(status: "preparing_to_ship")
    else
      @order.update(status: "in_production")
    end
    redirect_to admin_order_path(@order)
  end


  private

  def order_details_params
    params.require(:order_detail).permit(:production_status)
  end


end
