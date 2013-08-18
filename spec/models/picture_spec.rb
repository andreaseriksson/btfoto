require 'spec_helper'

describe Picture do
  
  let(:picture) { FactoryGirl.create(:picture) }
  
  it "has a valid factory" do
    picture.should be_valid
  end
  
  it "populates relevant columns" do
    picture.year.should eq(12)
    picture.school.should eq("Torn-F1")
    picture.no.should eq("22")
    picture.rand.should eq(5544)
    picture.name.should eq("12Torn-F1-5544-22")
    picture.folder.should eq("#{Time.new.strftime("%Y%m%d")}")
    picture.image.file.filename.should eq("12Torn-F1-5544-22a.jpg")
    picture.letter.should eq("a")
  end
  
  it "has a sybling" do
    other_picture = FactoryGirl.create(:picture, image: File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-22b.jpg')))
    
    picture.syblings.should include(other_picture) 
  end
  
  it "is not it's own sybling" do
    other_picture = FactoryGirl.create(:picture, image: File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-22b.jpg')))
    
    picture.syblings.should_not include(picture)
  end
    
end
