require 'rails_helper'

RSpec.describe Cart, type: :model do

  let(:cart) { FactoryGirl.create(:cart) }

  it 'has a valid factory' do
    expect(cart).to be_valid
  end

  it 'responds to days_left' do
    expect(cart.days_left).to be > 20
  end

  it 'has 2 cart_items' do
    product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: true)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product)
    expect(cart.summary[:products].length).to eq 2
  end

  it 'sums up the cart' do
    expect(cart.summary[:sum_without_delivery]).to eq 200.0
  end

  it 'sums up quantity' do
    expect(cart.summary[:quantity]).to eq 2
  end

  it 'gives correct delivery' do
    expect(cart.summary[:delivery]).to eq 33
  end

  it 'is freight free' do
    product = FactoryGirl.create(:product, price: 220, vat: 0.25, freight: true)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product, quantity: 3)
    expect(cart.summary[:delivery]).to eq 0
  end

  it 'is freigt free when all products is freight free' do
    cart.cart_items = []
    product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: false)
    cart.cart_items << FactoryGirl.create(:cart_item, product: product, quantity: 1)
    expect(cart.summary[:delivery]).to eq 0
  end

end
