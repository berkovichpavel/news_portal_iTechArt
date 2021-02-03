class User < ApplicationRecord
  has_many :created_items, class_name: 'Item', foreign_key: 'author_id'
  has_many :comments
  has_many :reviews
  has_one :subscription

  has_one_attached :photo

  validates :last_name, presence: true
  validates :first_name, presence: true

  enum role: { admin: 'admin', redactor: 'redactor', correspondent: 'correspondent', user: 'user' }
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.nickname = auth.info.nickname
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end
end
