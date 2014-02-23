FactoryGirl.define do
  factory :cart_item do |f|
    cart
    product
    f.quantity 1
    f.image_nr "12Torn-F1-5544-22a"
  end
end
