class Micropost < ApplicationRecord
  belongs_to :user
  #belongs_to :micropost
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
end
