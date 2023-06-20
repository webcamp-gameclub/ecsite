class Order < ApplicationRecord
  enum payment_method: {credit:0, bank: 1}
  enum order_status: {wait: 0, check: 1, making: 2, standby: 3, sent:4}

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postage, presence: true
  # セレクトボタン内に1行でまとめて表示させるメソッド
  def address_display
    '〒' + postal_code + ' '+ address1 + ' ' + name
  end
end
