FactoryBot.define do
  factory :subscription do
    sending_frequency { 'instantly' }
    dispatch_hour { 5 }

    association :user, factory: :user
  end
end
