class RssSubscription < ApplicationRecord
  enum category: Item::CATEGORIES
  validates :reference_link, presence: true
  validates :category, presence: true
end
