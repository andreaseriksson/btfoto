# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    titel "MyString"
    slug "MyString"
    preamble "MyText"
    content "MyText"
  end
end
