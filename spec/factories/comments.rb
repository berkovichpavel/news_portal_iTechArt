FactoryBot.define do
  factory :comment do
    body { Faker::Hipster.sentence }

    association :user, factory: :user
    association :commentable, factory: :item

    factory :comments_for_seeds do
      association :user, factory: :user_with_different_role
    end

  end
end
