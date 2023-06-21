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
     flash[:notice] = "登録が成功しました"
     redirect_to admin_item_path(@item)
   else
      render :new
   end
  end
  
  def edit
    @item= Item.find(params[:id])
  end
  
  def update
     @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集が成功しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :description, :image, :genre_id, :price,)
  end
  
end
