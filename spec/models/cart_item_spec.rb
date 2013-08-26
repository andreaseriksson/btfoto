require 'spec_helper'

describe CartItem do
  
  it "has a valid factory" do
    build(:cart_item).should be_valid
  end
  
  it "must have an image_nr" do
    build(:cart_item, image_nr: nil).should_not be_valid
  end
  
  it "belongs to cart" do
    build(:cart_item, cart: nil).should_not be_valid
  end
  
  it "belongs to product" do
    build(:cart_item, product: nil).should_not be_valid
  end
   
end
