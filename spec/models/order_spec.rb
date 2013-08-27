require 'spec_helper'

describe Order do
  
  it "has a valid factory" do
    order = build(:order)
    order.should be_valid
  end
  
  its "invalid without first name" do
    order = build(:order, first_name: nil)
    order.should_not be_valid
  end
  
  its "invalid without family name" do
    order = build(:order, family_name: nil)
    order.should_not be_valid
  end
  
  its "invalid without address1" do
    order = build(:order, address1: nil)
    order.should_not be_valid
  end
  
  it "valid without address2" do
    order = build(:order, address2: nil)
    order.should be_valid
  end
  
  its "invalid without phone" do
    order = build(:order, phone: nil)
    order.should_not be_valid
  end
  
  its "invalid without email" do
    order = build(:order, email: nil)
    order.should_not be_valid
  end
  
  its "invalid without a correct email" do
    order = build(:order, email: "fakeemail.com")
    order.should_not be_valid
  end
  
  its "invalid without city" do
    order = build(:order, city: nil)
    order.should_not be_valid
  end
  
  its "invalid without zip-code" do
    order = build(:order, zip: nil)
    order.should_not be_valid
  end
  
  it "saves a token in the database" do
    order = build(:order, token: nil)
    order.save
    order.token.should_not be nil
  end
  
  it "can confirm an order" do
    order = build(:order, confirmed:false)
    order.confirm
    order.confirmed.should be true
  end
    
end
