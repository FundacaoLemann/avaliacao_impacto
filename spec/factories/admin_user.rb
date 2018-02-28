FactoryBot.define do
  factory :admin_user do
    email { FFaker::Internet.unique.email }
    password "password"
    password_confirmation "password"

    trait :admin do
      role :admin
    end

    trait :service_manager do
      role :service_manager
    end

    trait :service_analyst do
      role :service_analyst
    end

    trait :lemann do
      role :lemann
    end
  end
end
