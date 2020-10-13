class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 4 }, uniqueness: true
  validates :fullname, presence: true, length: { minimum: 7 }

  has_many :opinions

  has_many :followings, class_name: 'Following', foreign_key: 'user_id', dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'following_id', dependent: :destroy

end
