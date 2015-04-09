FactoryGirl.define do
  factory :regular_team do
    sequence(:name) { |n| "Regular Team #{n}" }
  end
end
