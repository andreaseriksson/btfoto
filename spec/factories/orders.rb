# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    first_name "MyString"
    family_name "MyString"
    address1 "MyString"
    address2 "MyString"
    phone "MyString"
    email "MyString"
    city "MyString"
    zip "MyString"
    shipping_cost "9.99"
    confirmed false
    token "MyString"
    payment_type "MyString"
    extra_shipment false
  end
end
