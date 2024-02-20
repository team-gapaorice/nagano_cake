class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    if params[:items_name]
      @items = Item.where('name like ?', "%#{params[:items_name]}%").page(params[:page])


    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
    else
      @items = Item.order('id DESC').limit(4).page(params[:page])
    end
  end

  def about
  end

end
