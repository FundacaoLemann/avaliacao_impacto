FactoryGirl.define do
  factory :city do
    name 'São Bento'
    association :state, factory: :state
  end
end