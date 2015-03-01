require 'rails_helper'

describe Gallery do
  let(:gallery) { create(:gallery) }

  it "has a valid factory" do
    gallery.should be_valid
  end

  its "invalid without image" do
    gallery = build(:gallery, image: nil)
    gallery.should_not be_valid
  end

  it "can change position" do
    first_gallery = gallery
    second_gallery = create(:gallery, image: File.open(File.join(Rails.root, '/spec/fixtures/files/gallery2.jpg')) )
    Gallery.first.should eq gallery
    first_gallery.move_lower
    Gallery.first.should eq second_gallery
  end

end
