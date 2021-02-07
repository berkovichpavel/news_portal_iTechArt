FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Hipster.sentence }

    association :user, factory: :user
    association :item, factory: :item

    factory :review_for_seeds do
      association :user, factory: :user_with_different_role
    end
  end
end
