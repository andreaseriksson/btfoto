FactoryGirl.define do
  factory :cart do |f|
    
    f.image_nr '12Torn-F1-5544-22a' 
    
    after(:create) do |cart|
      picture = FactoryGirl.create(:picture)
      product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: true)
      cart.cart_items << FactoryGirl.create(:cart_item, cart: cart, product: product, quantity: 2)
    end  
  end
end
