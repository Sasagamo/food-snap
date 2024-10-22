class PostRating < ApplicationRecord
  belongs_to :post
  belongs_to :rating

  validates :score, presence: true, numericality: { only_integer: true }
end
