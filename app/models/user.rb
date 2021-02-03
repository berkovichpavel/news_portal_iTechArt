class User < ApplicationRecord
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
         :confirmable,
         :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      info = auth.info.name.split(' ')
      user.first_name = info.first unless info[0].blank?
      user.last_name = info.last unless info[1].blank?
      user.nickname = auth.info.nickname
      user.skip_confirmation!
    end
  end
end
