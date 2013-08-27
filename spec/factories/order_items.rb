# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    order
    product
    quantity 1
    price "9.99"
    vat "9.99"
    discount "9.99"
    image_nr "12Torn-F1-5544-22a"
  end
end
