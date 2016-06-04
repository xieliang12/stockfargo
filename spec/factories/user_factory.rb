FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "first#{n}@testemail.com" }
    password "password"
  end
end
