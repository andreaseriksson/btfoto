require 'spec_helper'

describe Cart do
  
  let(:cart) { FactoryGirl.create(:cart) }
  
  it "has a valid factory" do
    cart.should be_valid
  end
  
  it "responds to days_left" do
    cart.days_left.should be > 20 
  end
    
  it "has 2 cart_items" do
    product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: true)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product)
    cart.summary[:products].length.should eq 2
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

  it "is freight free" do
    product = FactoryGirl.create(:product, price: 220, vat: 0.25, freight: true)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product, quantity: 3)
    cart.summary[:delivery].should eq 0
  end

  it "is freigt free when all products is freight free" do
    cart.cart_items = []
    product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: false)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product, quantity: 1)
    cart.summary[:delivery].should eq 0
  end

end
