class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 10 }, uniqueness: true
  validates :fullname, presence: true

  has_many :opinions

  has_many :followings, class_name: 'Following', foreign_key: 'user_id', dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'following_id', dependent: :destroy

end
