class Public::OrdersController < ApplicationController
  def new
    @cart_items = current_customer.cart_items
    # カートの中に商品が入っている場合
    if @cart_items.any?
      @order = Order.new
      @addresses = current_customer.addresses
    # カートの中に商品がない場合オーダーには進めない
    else
    redirect_to cart_items_path
    end
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      # カートの情報をオーダーディティールに複製
      current_customer.cart_items.each do |cart_item|
        order_detail = OrderDetail.new()
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.quantity = cart_item.amount
        order_detail.subprice = cart_item.item.tax_price
        order_detail.save
      end
      # カートの中身を削除
      current_customer.cart_items.destroy_all
      redirect_to thanks_orders_path
    end
  end

  def confirm
    # @orderはでかい箱で、その中に小さい箱を指定するためにストロングパラメーターを指定している。
    @order = Order.new(order_params)
      # ご自身の住所と配送先住所が選択された場合はhiddenで処理
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address1 = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    # collection.selectであれば
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:address_id])
      # 配送先住所を登録していないのであれば１のラジオボタンを押しても先には進めない
      if current_customer.addresses.exists?
      @order.postal_code = ship.pastal_code
      @order.address1 = ship.address
      @order.name = ship.name
      end
    # 新規住所入力であれば
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:pastal_code]
      @order.address1 = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
      # 郵便番号（ハイフンなし7桁）、配送先住所、配送先氏名が入力されてたらture
      unless @order.postal_code =~ /\A[0-9]{7}\z/ && !@order.address1.empty? && !@order.name.empty?
       flash[:notice] = "・郵便番号が正しくありません、または未入力の項目があります"
       redirect_to request.referer
      end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    # sumの初期値を0にしてから小計を加算
    @total = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.total_price }
  end

   private
  
  def order_params
    params.require(:order).permit(:customer_id, :name, :address1, :postal_code, :postage, :billing_amount, :payment_method, :order_status)
  end

end
