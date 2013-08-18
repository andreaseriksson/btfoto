# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    order nil
    product nil
    quantity 1
    price "9.99"
    vat "9.99"
    discount "9.99"
    image_nr "MyString"
  end
end
