FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    role { 'admin' }
    bio { 'Example of bio' }
  end
end
