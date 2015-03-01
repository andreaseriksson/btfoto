FactoryGirl.define do
  factory :order do
    first_name "Nisse"
    family_name "Gunnarsson"
    address1 "Testvägen 1"
    address2 "2 tr"
    phone "0121-4515123"
    email "nisse@example.com"
    city "Ystad"
    zip "11111"
    shipping_cost "9.99"
    confirmed false
    token "12321213112121321132131231"
    payment_type "card"
    extra_shipment false

    #after(:create) do |order|
    #  product = FactoryGirl.create(:product, price: 80, vat: 0.25, freight: true)
    #  order.order_items << FactoryGirl.create(:order_item, product: product, quantity: 2)
    #end
  end
end
