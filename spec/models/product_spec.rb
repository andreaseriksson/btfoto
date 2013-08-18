require 'spec_helper'

describe Product do
  
  let(:product) { FactoryGirl.create(:product) }
  
  it "has a valid factory" do
    product.should be_valid
  end
  
  it "is invalid whithout a name" do
    product = FactoryGirl.build(:product, name: nil)
    product.should_not be_valid
  end
    
end
