FactoryBot.define do
  factory :item do
    title { Faker::Lorem.paragraph_by_chars(number: 90) }
    short_description { Faker::Lorem.paragraph_by_chars(number: 100) }
    full_text { Faker::Lorem.paragraph(sentence_count: 20..45) }
    category { 'auto' }
    mask { 'visible' }
    status { 'active' }

    association :author, factory: :user

    factory :important_item do
      flag { true }
    end

    factory :item_with_comments_and_reviews do
      tag_list { Faker::Lorem.words(number: 2..5) }
      category { Item.categories.values.sample }
      mask { Item.masks.values.sample }
      status { Item.statuses.values.sample }
      main_img { 'https://baconmockup.com/' + Faker::Number.between(from: 640, to: 800).to_s + '/' + Faker::Number.between(from: 360, to: 520).to_s }
      flag { [true, false].sample }
      transient do
        comments_count { Faker::Number.between(from: 15, to: 35) }
        review_count { Faker::Number.between(from: 10, to: 25) }
      end

      after(:create) do |item, evaluator|
        create_list(:comments_for_seeds, evaluator.comments_count, commentable: item)
        create_list(:review_for_seeds, evaluator.review_count, item: item)
        item.reload
      end
    end
  end
end
