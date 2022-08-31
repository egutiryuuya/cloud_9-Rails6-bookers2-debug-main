class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users,through: :group_users,dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :name,presence: true, uniqueness: true
  has_one_attached :group_image
  
  def get_group_image
    group_image.attached? ? group_image : 'no_image.jpg'
  end
end
