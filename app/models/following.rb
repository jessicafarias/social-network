class Following < ApplicationRecord
  validates :user_id, presence: true
  validates :following_id, presence: true

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :followed, class_name: 'User', foreign_key: 'following_id'
end
