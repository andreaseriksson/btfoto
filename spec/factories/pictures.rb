# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do |f|
    product_category
    f.image File.open(File.join(Rails.root, '/spec/fixtures/files/12Torn-F1-5544-22a.jpg'))
    f.shown false
  end
  
end
