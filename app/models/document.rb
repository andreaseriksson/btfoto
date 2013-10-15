class Document < ActiveRecord::Base
  
  mount_uploader :file_name, DocumentUploader
  
  default_scope -> { order("file_name ASC") }
  
end
