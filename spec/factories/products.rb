FactoryGirl.define do
  factory :product do |f|
    f.name "1111. Standard paketet s/v + gruppbild färg (förskola)"
    f.price 308.8
    f.vat 0.25
    f.discount 0
    f.allow_discount false
    f.freight false
    f.image File.open(File.join(Rails.root, '/spec/fixtures/files/1111.jpg'))
  end
end