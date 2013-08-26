# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery do
    image File.open(File.join(Rails.root, '/spec/fixtures/files/gallery1.jpg'))
  end
end
