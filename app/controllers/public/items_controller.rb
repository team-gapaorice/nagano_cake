class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:items_name]
      @items = Item.where('name like ?', "%#{params[:items_name]}%").page(params[:page])


    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
    else
      @items = Item.page(params[:page])
      @counts = Item.count
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end