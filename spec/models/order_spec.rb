require 'rails_helper'

RSpec.describe Order, type: :model do

  context 'validations' do
    it 'has a valid factory' do
      order = FactoryGirl.build(:order)
      expect(order).to be_valid
    end

    it 'invalid without first name' do
      order = FactoryGirl.build(:order, first_name: nil)
      expect(order).not_to be_valid
    end

    it 'invalid without family name' do
      order = FactoryGirl.build(:order, family_name: nil)
      expect(order).not_to be_valid
    end

    it 'invalid without address1' do
      order = FactoryGirl.build(:order, address1: nil)
      expect(order).not_to be_valid
    end

    it 'valid without address2' do
      order = FactoryGirl.build(:order, address2: nil)
      expect(order).to be_valid
    end

    it 'invalid without phone' do
      order = FactoryGirl.build(:order, phone: nil)
      expect(order).not_to be_valid
    end

    it 'invalid without email' do
      order = FactoryGirl.build(:order, email: nil)
      expect(order).not_to be_valid
    end

    it 'invalid without a correct email' do
      order = FactoryGirl.build(:order, email: 'fakeemail.com')
      expect(order).not_to be_valid
    end

    it 'invalid without city' do
      order = FactoryGirl.build(:order, city: nil)
      expect(order).not_to be_valid
    end

    it 'invalid without zip-code' do
      order = FactoryGirl.build(:order, zip: nil)
      expect(order).not_to be_valid
    end
  end

  it 'saves a token in the database' do
    order = FactoryGirl.create(:order, token: nil)
    expect(order.token).not_to be nil
  end

  it 'responds to order_nr' do
    order = FactoryGirl.create(:order)
    expect(order.order_nr).to eq 3201
  end

  it 'can confirm an order' do
    order = FactoryGirl.create(:order, confirmed: false)
    order.confirm
    expect(order.confirmed).to be true
  end

  context 'order content' do

    before do
      @order = FactoryGirl.create(:order)
    end

    it 'has pictures' do
      expect(@order.order_pictures).to eq []
    end

  end

end
