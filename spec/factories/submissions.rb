FactoryBot.define do
  factory :submission do
    association :school, factory: :school
    status [:redirected, :in_progress, :submitted].sample
    school_phone "123"
    submitter_name { FFaker::Internet.name }
    submitter_email { FFaker::Internet.email }
    submitter_phone "123"
    response_id { rand(1..10) }
    redirected_at { FFaker::Time.datetime }
    saved_at { FFaker::Time.datetime }
    modified_at { FFaker::Time.datetime }
    submitted_at { FFaker::Time.datetime }
    form_name "baseline"
    administration "Rede Federal do Brasil"
  end
end
