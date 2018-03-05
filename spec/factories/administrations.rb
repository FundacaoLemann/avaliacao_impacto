FactoryBot.define do
  factory :administration do
    type [:federal, :estadual, :municipal].sample
    association :state, factory: :state
    association :city, factory: :city
    preposition ["de", "da", "do"].sample
  end
end
