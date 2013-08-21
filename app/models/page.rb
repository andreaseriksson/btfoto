class Page < ActiveRecord::Base
  has_ancestry
  
  acts_as_list scope: [:ancestry]
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, presence: true
  
  scope :active, -> { where(active: true) }
  default_scope -> { order("position ASC") }
  
end
