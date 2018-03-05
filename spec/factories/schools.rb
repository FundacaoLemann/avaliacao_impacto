FactoryBot.define do
  factory :school do
    inep { rand(1..1000) }
    name { FFaker::Company.name }
    tp_dependencia { rand(1..3) }
    tp_dependencia_desc %w[Federal Estadual Municipal].sample
    cod_municipio { rand(1..1000) }
    municipio { FFaker::AddressBR.city }
    unidade_federativa { FFaker::AddressBR.state }
    num_estudantes { rand(1..100) }
    ano_censo 2018
    sample [true, false].sample
  end
end
