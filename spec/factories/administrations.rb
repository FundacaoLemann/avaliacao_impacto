FactoryBot.define do
  factory :administration do
    adm [:federal, :estadual, :municipal].sample
    association :state, factory: :state
    association :city, factory: :city
    preposition ["de", "da", "do"].sample
    name { FFaker::Internet.user_name }
  end
end
