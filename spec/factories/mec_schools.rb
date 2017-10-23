FactoryGirl.define do
  factory :mec_school do
    inep { rand(1..1000) }
    name "Escola MEC"
  end
end
