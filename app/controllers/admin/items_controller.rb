class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
     @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end
  def create
  @item = Item.new(item_params)
   if @item.save
     redirect_to admin_item_path(@item)
   else
      render :new
   end
  end
  def edit
  end
  private
  def item_params
    params.require(:item).permit(:name, :description, :image)
  end
  
end
