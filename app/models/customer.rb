class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy     
  has_many :addresses, dependent: :destroy
  
  # 氏名をまとめたメソッド
  def customer_name
    last_name + first_name
  end
end
