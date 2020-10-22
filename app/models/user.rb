class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 4 }, uniqueness: true
  validates :fullname, presence: true, length: { minimum: 7 }
  validates :avatar, presence: true
  validates :cover_image, presence: true

  has_many :opinions, class_name: 'Opinion', foreign_key: 'user_id'
  has_many :relationship, class_name: 'Following', foreign_key: 'user_id', dependent: :destroy
  has_many :followings, through: :relationship

  scope :fans, ->(user) { joins(:relationship).where('following_id=?', user.id).includes([avatar_attachment: :blob]) }
  scope :who_to_follow, lambda { |user|
                          where('id != ?', user.id)
                            .includes([avatar_attachment: :blob]) - user.followings.includes([avatar_attachment: :blob])
                        }
  scope :order_desc, -> { order(created_at: :desc).includes([avatar_attachment: :blob]) }

  scope :with_attached_avatar, -> { includes(avatar_attachment: :blob) }

  has_one_attached :avatar, dependent: :destroy
  has_one_attached :cover_image, dependent: :destroy

  def start_to_follow(user)
    @following = relationship.build(user_id: id, following_id: user.id)
    @following.save
  end

  def stop_to_follow(user)
    @following = relationship.find_by(following_id: user.id)
  end

  def follow?(user)
    return true if user == self

    followings.include?(user)
  end
end
