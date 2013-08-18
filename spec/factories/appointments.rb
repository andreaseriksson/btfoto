# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment do
    label "Photoshoot"
    start_time "2013-07-07 19:20:55"
    approved false
    booked false
    name "Nisse Gunnarsson"
    email "person@example.com"
    phone "012345678"
  end
end
