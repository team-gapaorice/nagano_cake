class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      flash[:notice] = "カートに商品を追加しました。"
      redirect_to cart_items_path

    elsif @cart_item.save
      flash[:notice] = "カートに商品を追加しました。"
      @cart_items = current_customer.cart_items.all
      render :index
    else
      flash[:notice] = "商品の追加に失敗しました。"
      render :index
    end
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    flash[:notice] = "商品の個数を変更しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items.all
    cart_items.destroy_all
    flash[:notice] = "カート内の商品を全削除しました。"
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "カート内の商品を削除しました。"
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
