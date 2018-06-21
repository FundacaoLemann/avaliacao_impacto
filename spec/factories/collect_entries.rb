FactoryBot.define do
  factory :collect_entry do
    name { FFaker::Name.name }
    school_inep { rand(1..10) }
    adm_cod "1"
    size 3
    sample_size 2
    school_sequence 1
    group %w[Amostra Repescagem].sample
    substitute false
    quitter false
    card_id { rand(1..10) }

    association :collect, factory: :collect
  end

  trait :amostra do
    group "Amostra"
  end

  trait :repescagem do
    group "Repescagem"
  end

  trait :substitute do
    substitute true
  end

  trait :quitter do
    quitter true
  end
end
