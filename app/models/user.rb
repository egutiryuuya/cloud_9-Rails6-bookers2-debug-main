class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # フォローしてくれたユーザー
  has_many :relationships,class_name: "Relationship", foreign_key: :following_id,dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  # フォローしたユーザー
  has_many :reverse_of_relationships,class_name: "Relationship", foreign_key: :follower_id,dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
 
  has_one_attached :profile_image

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
  #フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォロー外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
