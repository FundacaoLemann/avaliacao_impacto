FactoryBot.define do
  factory :state do
    acronym 'PB'
    name { FFaker::AddressBR.state }
  end
end
