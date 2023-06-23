class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(10)
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
     flash[:notice] = "商品を追加しました"
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
      flash[:notice] = "商品を編集しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image, :genre_id,:price,:is_selled)
  end

end
