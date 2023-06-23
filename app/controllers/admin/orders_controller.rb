class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @product_total = @order_details.inject(0) { |sum, order_detail| sum + order_detail.total_price }
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(making_status: 1) if @order.order_status == "check"
    end 
      redirect_to admin_order_path
  end 
  
  
  private
  def order_params
    params.require(:order).permit(:order_status)
  end 
  
end
