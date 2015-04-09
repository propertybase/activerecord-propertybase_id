FactoryGirl.define do
  factory :customized_user do
    sequence(:email) { |n| "user#{n}@propertybase.com" }
  end
end
