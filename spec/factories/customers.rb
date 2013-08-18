# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    username "MyString"
    password "MyString"
    first_name "MyString"
    family_name "MyString"
    address "MyString"
    zip "MyString"
    city "MyString"
    country "MyString"
    phone "MyString"
    cellphone "MyString"
    active false
  end
end
