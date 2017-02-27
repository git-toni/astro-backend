require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:name){ Faker::Name.name }
    #name  Faker::Name.name
    sequence(:email) { Faker::Internet.email }
    password '123123'
  end
  factory :telescope do
    sequence(:name){ Faker::Food.ingredient }
    sequence(:cospar_id){ Faker::Code.asin }
    sequence(:regime){ Faker::Food.spice}
    sequence(:operator){ Faker::Space.agency_abv}
  end
  factory :post do
    sequence(:image_url){ Faker::Fillmurray.image}
    sequence(:description){ Faker::Lorem.sentence}
  end
end
