class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :post_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  is_impressionable counter_cache: true
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_yesterday2, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_yesterday3, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_yesterday4, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_yesterday5, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_yesterday6, -> { where(created_at: 6.day.ago.all_day) }
        
  
  scope :created_thisweek, ->{ where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
   
  scope :created_lastweek, ->{ where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end