class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms  #１つのルームにいるユーザ名は２人のためhas_manyになる
end
