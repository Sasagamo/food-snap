class Rating < ApplicationRecord
  belongs_to :user
  has_many :posts, through: :post_ratings
  has_many :post_ratings, dependent: :destroy

  validates :rating_name, presence: true, length: { maximum: 10 }

end
