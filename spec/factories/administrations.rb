FactoryBot.define do
  factory :administration do
    adm [:federal, :estadual, :municipal].sample
    preposition ["de", "da", "do"].sample
    name { FFaker::Internet.user_name }
    cod { "#{rand(1..10)}-#{rand(1..1000)}" }
  end
end
