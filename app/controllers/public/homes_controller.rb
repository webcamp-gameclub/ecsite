class Public::HomesController < ApplicationController
  def top
    @items = Item.order("id DESC").limit(4)
    @genres = Genre.all
  end
  
  def index
    if params[:id]
      @genres = Genre.all
      @genre = Genre.find(params[:id])
      @items = @genre.items.where(params[:id])
    else
      @items = Item.all
      @genres = Genre.all
      render :top
    end
  end      

  def about
  end
end
