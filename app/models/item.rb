require 'rss'
require 'open-uri'

class Item < ApplicationRecord
  acts_as_taggable

  CATEGORIES = { 'news' => 'news', 'health' => 'health', 'finance' => 'finance', 'auto' => 'auto', 'people' => 'people',
                 'technology' => 'technology', 'realty' => 'realty' }.freeze
  after_save :send_item_instantly
  before_save :published_time

  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true
  has_many :comments, as: :commentable
  has_many :reviews
  has_many :item_views, dependent: :destroy

  has_one_attached :main_img_href

  enum status: { 'active' => 'active', 'archive' => 'archive', 'revision' => 'revision', 'check' => 'check' }
  enum active_status: { 'inactive' => 'inactive', 'published' => 'published', 'archived' => 'archived' }
  enum category: CATEGORIES
  enum mask: { 'visible' => 'visible', 'title_annotation' => 'title_annotation',
               'only_header' => 'only_header', 'hidden_unregistered' => 'hidden_unregistered' }

  validates :title, presence: true, length: { maximum: 150 }
  validates :short_description, presence: true, length: { minimum: 20, maximum: 800 }
  validates :full_text, presence: true, length: { minimum: 50 }
  validates :category, presence: true
  validates :mask, presence: true
  validates :status, presence: true
  validates :author, presence: true, unless: :rss?

  def send_item_instantly
    FindUsersInstantlyJob.perform_now(id)
  end

  def published_time
    if status == 'active'
      self.published_at ||= Time.current
    else
      self.published_at = nil
    end
  end
end
