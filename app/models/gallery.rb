class Gallery < ActiveRecord::Base
  
  mount_uploader :image, GalleryUploader
  
  include RankedModel
  ranks :position
  include Sortable
  
  default_scope -> { order("position ASC") }
  
end
