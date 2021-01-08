class RssSubscription < ApplicationRecord
  enum category: Item::CATEGORIES
end
