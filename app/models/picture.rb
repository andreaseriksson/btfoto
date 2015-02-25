class Picture < ActiveRecord::Base
  mount_uploader :image, PictureUploader

  belongs_to :product_category

  before_create :populate_fields

  scope :current_image, ->(image_nr) { where(name: image_nr[0, (image_nr.length - 1)], letter: image_nr[-1, 1]) }

  def image_nr
    "#{name}#{letter}"
  end

  def syblings
    Picture.where(year: year, school: school, no: no).where('id != ?', id).order(:letter)
  end

  def group_image
    Picture.where(year: year, school: school, no: '00').first
  end

  private

  def populate_fields
    # Image filename is formated as:
    # 12Torn-F1-5544-22a.jpg
    # year: 12, school: Torn-F1, rand: 5544, no: 22, letter: a
    s = image.file.filename

    if s.include?('.jpg')
      self.no = s[-7, 2]
      self.letter = s[-5, 1]
      self.rand = s[-12, 4]
      self.year = s[0, 2]
      self.school = s[0, (s.length-13)][2, s.length]
      self.name = "#{self.year}#{self.school}-#{s[-12, 4]}-#{self.no}"
      self.folder = "#{self.year}#{self.school.parameterize}"
    end
  end
end

