class Item < ApplicationRecord
 has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  #validates :genre_id, presence: true
  validates :price, presence: true
  
  # 消費税を含む金額
  def tax_price
    (price * 1.1).floor
  end
end
