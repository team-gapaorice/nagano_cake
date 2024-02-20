class Public::DeliveryDestinationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @delivery_destinations = current_customer.delivery_destinations.page(params[:page]).per(3)
    @delivery_destination = DeliveryDestination.new
  end

  def create
    @delivery_destination = DeliveryDestination.new(delivery_destination_params)
      @delivery_destination.customer_id = current_customer.id
      if @delivery_destination.save
        flash[:notice] = "配送先を作成しました。"
        redirect_to delivery_destinations_path
      else
      render :index
      end
  end

  def edit
    @delivery_destination = DeliveryDestination.find(params[:id])
  end

  def update
    @delivery_destination = DeliveryDestination.find(params[:id])
    @delivery_destination.update(delivery_destination_params)
    flash[:notice] = "配送先住所を更新しました。"
    redirect_to delivery_destinations_path
  end

  def destroy
    delivery_destination = DeliveryDestination.find(params[:id])
    delivery_destination.destroy
    flash[:notice] = "配送先を削除しました。"
    redirect_to delivery_destinations_path
  end

  private

  def delivery_destination_params
     params.require(:delivery_destination).permit(:name, :postal_code, :adress)
  end

end
