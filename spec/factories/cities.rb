FactoryBot.define do
  factory :city do
    name { FFaker::AddressBR.city }
    association :state, factory: :state
    ibge_code { rand(1..1000) }
  end
end
