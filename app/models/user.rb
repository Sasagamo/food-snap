class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :ratings

  # Validations
  validates :account_name, presence: true, uniqueness: true,format: { with: /\A[a-zA-Z0-9]{8,16}\z/, message: 'must be between 8 and 16 characters and contain only alphanumeric characters' }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :bio, length: { maximum: 100 } 

  has_one_attached :avatar
  validate :avatar_size
  validate :avatar_content_type
  
  private

  def avatar_size
    return unless avatar.attached?
    
    if avatar.byte_size > 5.megabytes
      errors.add(:avatar, "must be less than 5MB")
    end
  end

  def avatar_content_type
    return unless avatar.attached?
    
    unless avatar.content_type.in?(%w[image/jpeg image/gif image/png])
      errors.add(:avatar, "must be a JPEG, GIF, or PNG")
    end
  end
end
