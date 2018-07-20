FactoryBot.define do
  factory :submission do
    status [:redirected, :in_progress, :submitted].sample
    school_phone "123"
    submitter_name { FFaker::Name.name }
    submitter_email { FFaker::Internet.email }
    submitter_phone "123"
    response_id { rand(1..10) }
    redirected_at { FFaker::Time.datetime }
    saved_at { FFaker::Time.datetime }
    modified_at { FFaker::Time.datetime }
    submitted_at { FFaker::Time.datetime }
    form_name "form name"
    adm_cod "1"
    card_id { rand(1..10) }
  end

  trait :redirected do
    status :redirected
    redirected_at { DateTime.now }
  end

  trait :in_progress do
    status :in_progress
    saved_at { DateTime.now }
  end

  trait :submitted do
    status :submitted
    submitted_at { DateTime.now }
  end
end
