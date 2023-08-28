FactoryBot.define do
  factory :market do 
    name { Faker::Name.name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    county { Faker::Address.community }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end