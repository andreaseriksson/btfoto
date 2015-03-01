require 'rails_helper'

describe ProductCategory do
  it 'has a valid factory' do
    FactoryGirl.create(:product_category).should be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:product_category, name: nil).should_not be_valid
  end

  it 'creates slug on creation' do
    product_category = FactoryGirl.create(:product_category)
    product_category.slug.should_not eq(nil)
  end
end
