class Item < ApplicationRecord
  enum categories: %w[news health finance auto]
end
