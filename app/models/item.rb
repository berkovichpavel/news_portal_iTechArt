class Item < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  after_save :send_item_instantly
  before_save :published_time
  acts_as_taggable

  has_many :comments, as: :commentable
  has_many :reviews
  has_and_belongs_to_many :users
  has_many :item_views

  has_one_attached :main_img_href

  enum status: { 'active' => 'active', 'archive' => 'archive', 'revision' => 'revision', 'check' => 'check' }
  enum active_status: { 'inactive' => 'inactive', 'published' => 'published', 'archived' => 'archived' }
  enum category: { 'news' => 'news', 'health' => 'health', 'finance' => 'finance', 'auto' => 'auto', 'people' => 'people',
                   'technology' => 'technology', 'realty' => 'realty' }

  enum mask: { 'visible' => 'visible', 'title_annotation' => 'title_annotation',
               'only_header' => 'only_header', 'hidden_unregistered' => 'hidden_unregistered' }

  validates :title, presence: true, length: { maximum: 150 }
  validates :short_description, presence: true, length: { minimum: 20, maximum: 300 }
  validates :full_text, presence: true, length: { minimum: 100 }
  validates :category, presence: true
  validates :mask, presence: true

  def send_item_instantly
    FindUsersInstantlyJob.perform_now(id)
  end

  def published_time
    if self.status == 'active'
      self.published_at ||= Time.current
    else
      self.published_at = nil
    end
  end
end
