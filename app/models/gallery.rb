class Gallery < ActiveRecord::Base
  
  mount_uploader :image, GalleryUploader
  
  include RankedModel
  ranks :position
  include Sortable
  
  validates_presence_of :image
  
  default_scope -> { order("position ASC") }
  
end
