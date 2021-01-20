class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :rating, presence: true, numericality: true
end
