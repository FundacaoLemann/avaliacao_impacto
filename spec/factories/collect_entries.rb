FactoryBot.define do
  factory :collect_entry do
    name "Francisco Morato_1_3"
    school_inep "35583613"
    adm_cod "3-3516309"
    size 3
    sample_size 2
    school_sequence 1
    group "Amostra"
    association :collect, factory: :collect
  end
end
