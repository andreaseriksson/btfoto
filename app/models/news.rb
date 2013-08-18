class News < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, presence: true
  
  default_scope -> { order("created_at DESC") }
  
end
