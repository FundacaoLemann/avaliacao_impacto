FactoryGirl.define do
  factory :form_option do
    sections_to_show ['A', 'B', 'C']
    dependencia_desc "Estadual"
    state_or_city "Paraíba"
  end
end
