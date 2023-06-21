class Genre < ApplicationRecord
<<<<<<< Updated upstream
  has_many :items, dependent: :destroy
  
  validates :genre, presence: true
=======

  validates :name, presence:true
  has_many :items, dependent: :destroy

>>>>>>> Stashed changes
end
