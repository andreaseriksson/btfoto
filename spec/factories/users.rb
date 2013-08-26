# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.password "secret"
  end
end
