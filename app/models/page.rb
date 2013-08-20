class Page < ActiveRecord::Base
  has_ancestry
  
  include RankedModel
  ranks :position, with_same: :ancestry
  include Sortable
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, presence: true
  
  scope :active, -> { where(active: true) }
  default_scope -> { order("position ASC") }
  
end
