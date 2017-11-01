require 'ffaker'
FactoryGirl.define do
  factory :submission do
    school 1
    status "redirected"
    school_phone "123"
    submitter_name "name"
    submitter_email "email@email.com"
    submitter_phone "123"
    response_id 1
    redirected_at FFaker::Time.datetime
    created_at FFaker::Time.datetime
    modified_at FFaker::Time.datetime
    submitted_at FFaker::Time.datetime
  end
end
