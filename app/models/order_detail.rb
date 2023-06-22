class OrderDetail < ApplicationRecord
  enum making_status: { impossible: 0, stay: 1, making: 2, complete: 3 }

  belongs_to :order
  belongs_to :item

  # アイテム毎の小計を算出
  def total_price
    subprice.to_i * quantity.to_i
  end
end
