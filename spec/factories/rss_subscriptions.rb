FactoryBot.define do
  factory :rss_subscription do
    reference_link { 'https://news.tut.by/rss/economics.rss' }
    category { 'auto' }
  end
end
