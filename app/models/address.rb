class Address < ApplicationRecord
  belongs_to :customer
  
  validates :address, presence: true
  validates :pastal_code, presence: true,numericality: { only_integer: true }, length: { is: 7 }
  validates :name, presence: true
  
  # セレクトボタン内に1行でまとめて表示させるためのメソッド
  def address_display
    '〒' + pastal_code + ' ' + address + ' ' + name
  end
end
