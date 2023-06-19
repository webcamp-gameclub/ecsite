class Addre < ApplicationRecord
  belongs_to :customer
  
  validates :address, presence: true
  validates :pastal_code, presence: true,numericality: { only_integer: true }, length: { is: 7 }
  validates :name, presence: true
end
