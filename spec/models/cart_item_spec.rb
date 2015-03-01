require 'rails_helper'

RSpec.describe CartItem, type: :model do

  it 'has a valid factory' do
    cart_item = FactoryGirl.build(:cart_item)
    expect(cart_item).to be_valid
  end

  it 'must have an image_nr' do
    cart_item = FactoryGirl.build(:cart_item, image_nr: nil)
    expect(cart_item).not_to be_valid
  end

  it 'belongs to cart' do
    cart_item = FactoryGirl.build(:cart_item, cart: nil)
    expect(cart_item).not_to be_valid
  end

  it 'belongs to product' do
    cart_item = FactoryGirl.build(:cart_item, product: nil)
    expect(cart_item).not_to be_valid
  end
end
