FactoryGirl.define do
  factory :form do
    name FFaker::Internet.domain_word
    link FFaker::Internet.uri("https://www.tfaforms.com")
  end
end
