class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :created_items, class_name: 'Item', foreign_key: 'author_id'
  has_many :comments
  has_many :reviews
  has_one :subscription

  has_one_attached :photo

  validates :nickname, presence: true

  enum role: { admin: 'admin', redactor: 'redactor', correspondent: 'correspondent', user: 'user' }
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable # keeps statistics of the number of entries, takes into account time and IT addresses.
  # :omniauthable # authentication using social networks
end
