class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  has_many :follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :revers_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :revers_of_follows, source: :follower

  has_one_attached :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def follow(user_id)
    follows.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
end
