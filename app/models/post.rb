class Post < ApplicationRecord

  belongs_to :user
  has_many :post_ratings
  has_many :ratings, through: :post_ratings
  has_one_attached :store_image
  has_many_attached :food_images

  validates :store_name, presence: true
  validates :store_image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes } 
  validates :food_images,  content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 3.megabytes }

  validate :validate_post_ratings


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :genre

  with_options numericality:{ other_than: 1, message: "can't be blank" } do
    validates :genre_id
    validates :prefecture_id
  end

  private
  def validate_post_ratings
    post_ratings.each do |post_rating|
      post_rating.valid? # これにより各post_ratingのバリデーションが実行される
      post_rating.errors.full_messages.each do |message|
        errors.add(:base, message) # エラーメッセージをPostのエラーに追加
      end
    end
  end

end
