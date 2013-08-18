require 'spec_helper'

describe CartItem do
  
  let(:cart_item) { FactoryGirl.create(:cart_item) }
  
  it "has a valid factory" do
    cart_item.should be_valid
  end
  
  it "must have an image_nr" do
    cart_item = FactoryGirl.build(:cart_item, image_nr: nil)
    cart_item.should_not be_valid
  end
      
end
