require 'rails_helper'

RSpec.describe Picture, type: :model do

  let(:picture) { FactoryGirl.create(:picture) }

  it 'has a valid factory' do
    expect(picture).to be_valid
  end

  it 'populates relevant columns' do
    expect(picture.year).to eq 12
    expect(picture.school).to eq 'Torn-F1'
    expect(picture.no).to eq '22'
    expect(picture.rand).to eq 5544
    expect(picture.name).to eq '12Torn-F1-5544-22'
    expect(picture.folder).to eq '12torn-f1'
    expect(picture.image.file.filename).to eq '12Torn-F1-5544-22a.jpg'
    expect(picture.letter).to eq 'a'
  end

  it 'responds to image_nr' do
    expect(picture.image_nr).to eq '12Torn-F1-5544-22a'
  end

  it 'has a sybling' do
    other_picture = FactoryGirl.create(:picture, image: File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-22b.jpg')))
    expect(picture.syblings).to include other_picture
  end

  it 'is not it\'s own sybling' do
    FactoryGirl.create(:picture, image: File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-22b.jpg')))
    expect(picture.syblings).not_to include picture
  end

  it 'has a group_image' do
    group_image = FactoryGirl.create(:picture, image: File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-00a.jpg')))
    expect(picture.group_image).to eq group_image
  end

  it 'when quering for current image we should get that back image' do
    picture = FactoryGirl.create(:picture)
    current_picture = Picture.current_image('12Torn-F1-5544-22a').first
    expect(current_picture.id).to eq picture.id
  end
end
