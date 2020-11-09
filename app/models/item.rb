class Item < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :tags
  has_one_attached :main_img_href
  enum categories: %w[news health finance auto]
  enum access_mask: ['visible to everyone', 'title and annotation are visible', 'only visible header', 'hidden from unregistered users']
end
