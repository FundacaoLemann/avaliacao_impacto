FactoryBot.define do
  factory :pipefy_member, class: 'Pipefy::Member' do
    pipefy_id 1
    name { FFaker::Internet.user_name }
    email { FFaker::Internet.unique.email }
  end
end
