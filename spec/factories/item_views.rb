FactoryBot.define do
  factory :item_view do
    registered { true }
    user_ip { '11.23.123.46' }
    browser { 'Browser' }
    country { 'Belarus' }
    association :item, factory: :item
  end
end
