FactoryBot.define do
  factory :collect do
    name "Baseline 2017.2"
    phase "2017.2"
    deadline "2018-02-09 09:47:45"
    form_sections %w[A B C D E F G H I J K L M N O]
    form_assembly_params ""
    association :form, factory: :form
    status [:created, :in_progress, :paused, :archived].sample
  end
end
