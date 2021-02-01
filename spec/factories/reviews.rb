FactoryBot.define do
  factory :review do
    rating { 3 }
    comment { 'Amazing comment' }

    association :user, factory: :user
    association :item, factory: :item

  end
end
