FactoryBot.define do
  factory :comment do
    body { 'Amazing comment' }

    association :user, factory: :user
    association :commentable, factory: :item

  end
end
