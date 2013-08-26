class Gallery < ActiveRecord::Base
  
  mount_uploader :image, GalleryUploader
  
  acts_as_list
  
  validates_presence_of :image
  
  default_scope -> { order("position ASC") }
  
end
