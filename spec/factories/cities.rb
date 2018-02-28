FactoryBot.define do
  factory :city do
    name { FFaker::AddressBR.city }
    association :state, factory: :state
  end
end
