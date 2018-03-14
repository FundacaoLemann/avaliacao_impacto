FactoryBot.define do
  factory :administration do
    adm [:federal, :estadual, :municipal].sample
    preposition ["de", "da", "do"].sample
    name { FFaker::Internet.user_name }
  end
end
