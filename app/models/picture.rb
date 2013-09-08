class Picture < ActiveRecord::Base
  belongs_to :product_category
  
  mount_uploader :image, PictureUploader
  
  before_create :populate_fields
  
  
  def image_nr
    "#{self.name}#{self.letter}"
  end
  
  
  def populate_fields
    
    s = image.file.filename
    
    if s.include?(".jpg")
      self.no = s[-7,2] #s[-6,2]
      self.letter = s[-5,1] #s[-6,2]
      self.rand = s[-12,4] #s[-11,4]
      self.year = s[0,2]
      self.school = s[0,(s.length-13)][2,s.length] #s[0,(s.length-13)][2,s.length]
      self.name = "#{self.year}#{self.school}-#{self.rand}-#{self.no}" #image.file.filename
      self.folder = Time.new.strftime("%Y%m%d")
    end
    
  end
  
  scope :current_image, ->(image_nr) { where(name: image_nr[0,(image_nr.length-1)], letter: image_nr[-1,1]) }
  
  def syblings
    Picture.where(year: self.year, school: self.school, no: self.no).where.not(id: self.id).order(:letter)
  end
  
  def group_image
    Picture.where(year: self.year, school: self.school, no: '00').first
  end
  
end

