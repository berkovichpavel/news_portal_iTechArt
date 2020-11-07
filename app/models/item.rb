class Item < ApplicationRecord
  enum categories: %w[news health finance auto]
  has_rich_text :full_text
end
