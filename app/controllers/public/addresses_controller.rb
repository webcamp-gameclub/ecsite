class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:success] = "配送先を登録しました"
       redirect_to addresses_path
    else
      flash[:danger] = "追加に失敗しました"
      @address = Address.new
      @addresses = Address.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先を編集しました"
      redirect_to addresses_path
    else
      flash[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

   private

  def address_params
    params.require(:address).permit(:customer_id, :address, :pastal_code, :name)
  end    
    
end
