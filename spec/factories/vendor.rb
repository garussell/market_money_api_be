FactoryBot.define do
  factory :vendor do
    name { Faker::Artist.name }
    description { Faker::Quotes::Shakespeare.hamlet_quote }
    contact_name { Faker::Name.name }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { true }
  end
end