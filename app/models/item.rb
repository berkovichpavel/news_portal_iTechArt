class Item < ApplicationRecord
  belongs_to :user

  acts_as_taggable

  has_many :comments
  has_one_attached :main_img_href

  enum status: { approved: 'approved', revision: 'revision', check: 'check' }
  enum categories: %w[news health finance auto people technology realty]
  enum access_mask: ['visible to everyone', 'title and annotation are visible', 'only visible header', 'hidden from unregistered users']

  validates :title, presence: true, length: { maximum: 150 }
  validates :short_description, presence: true, length: { minimum: 20, maximum: 300 }
  validates :full_text, presence: true, length: { minimum: 100 }
  validates :category, presence: true
  validates :mask, presence: true
end
