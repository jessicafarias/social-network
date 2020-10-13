class Opinion < ApplicationRecord
  
  validates :body, presence: true, length: { minimum: 3 }
  belongs_to :user
end
