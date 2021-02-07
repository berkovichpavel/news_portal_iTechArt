FactoryBot.define do
  factory :subscription do
    sending_frequency { 'instantly' }
    dispatch_hour { Faker::Number.between(from: 0, to: 23) }

    association :user, factory: :user
  end
end
