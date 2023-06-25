class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy

  scope :only_active, -> { where(is_deleted: false) }


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }


  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy


  # 氏名をまとめたメソッド
  def customer_name
    last_name + first_name
  end

    def self.looks(search, word)
      @customers = Customer.where("first_name LIKE? OR last_name LIKE? OR first_name_kana LIKE? OR last_name_kana LIKE? OR phone_number LIKE? OR address LIKE? OR email LIKE?",
      "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
    end

end
