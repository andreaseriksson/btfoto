require 'rails_helper'

feature 'Order product' do

  before(:each) do
    @picture = FactoryGirl.create(:picture)
    @product = FactoryGirl.create(:product)
  end

  scenario 'successfully login' do
    sign_in
    current_path.should eq(store_path)
  end

  scenario 'unsuccessfully login' do
    sign_in_as 'nothing'
    current_path.should_not eq(store_path)
  end

  scenario 'views a product page' do
    sign_in
    first('a.display').click
    current_path.should eq(product_path(@product))
    page.should have_content(@product.description)
  end

  context 'cart functionality' do

    scenario 'adds a product to cart' do
      sign_in
      expect(page).not_to have_css '.well', text: 'Varukorg'
      click_button 'Lägg till'
      expect(page).to have_css '.well', text: 'Varukorg'
    end

    scenario 'displays cart count' do
      sign_in
      click_button 'Lägg till'
      expect(page).to have_css '#cart-content', text: '1 artikel i kundvagnen'
      click_button 'Lägg till'
      expect(page).to have_css '#cart-content', text: '2 artiklar i kundvagnen'
    end

    scenario 'sums up cart'

    scenario 'shows amount untill free shipping'

    scenario 'shows discount if days left'

    scenario 'shows days left box if days left'

  end

  context 'customer imgages' do

    scenario 'show customer image'



  end

  context 'checkout page' do

    scenario 'if empty cart'

    scenario 'table should contain product sum'



  end



end
