class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :ratings

  # Validations
  validates :account_name, presence: true, uniqueness: true
  validate :validate_account_name_format
  validates :nickname, presence: true, length: { maximum: 10 }, format: { without: /\s/, message: 'cannot contain spaces' }
  validates :bio, length: { maximum: 100 } 

  has_one_attached :avatar
  validate :avatar_size
  validate :avatar_content_type
  
  private
  def validate_account_name_format
    if account_name.present?
      unless account_name.match?(/\A[a-zA-Z0-9]{8,16}\z/)
        if account_name.length < 8 || account_name.length > 16
          errors.add(:account_name, 'must be between 8 and 16 characters')
        else
          errors.add(:account_name, 'can only contain alphanumeric characters')
        end
      end
    end
  end

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
