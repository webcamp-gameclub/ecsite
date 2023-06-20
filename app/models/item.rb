class Item < ApplicationRecord
 has_one_attached :image
  has_many :carts, dependent: :destroy
  
  # 消費税を含む金額
  def tax_price
    (price * 1.1).floor
  end
end
