FactoryBot.define do
  ROLES = %w[admin redactor correspondent user].freeze
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    role { 'admin' }
    bio { 'Example of bio' }
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)

    factory :user_with_different_role do
      role { ROLES.sample }
    end
  end
end
