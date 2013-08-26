require 'spec_helper'

describe Cart do
  
  let(:cart) { FactoryGirl.create(:cart) }
  
  it "has a valid factory" do
    cart.should be_valid
  end
  
  it "responds to days_left" do
    cart.days_left.should be > 0 
  end
    
  it "has 2 cart_items" do
    cart.summary[:products].length.should eq 1
  end
  
  it "sums up the cart" do
    cart.summary[:sum_without_delivery].should eq 200.0
  end
  
  it "sums up quantity" do
    cart.summary[:quantity].should eq 2
  end
  
  it "gives correct delivery" do
    cart.summary[:delivery].should eq 33
  end
end
