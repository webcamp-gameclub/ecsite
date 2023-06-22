class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true

  # 商品毎の小計を算出
  def subtotal
    item.tax_price * amount
  end
end
