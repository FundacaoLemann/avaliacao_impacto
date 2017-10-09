FactoryGirl.define do
  factory :school do
    inep { rand(1..1000) }
    name "Escola teste"
  end
end
