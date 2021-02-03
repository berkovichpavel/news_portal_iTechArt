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

  # def self.from_google(email:, uid:, avatar_url:)
  #   create_with(uid: uid, avatar_url: avatar_url).find_or_create_by!(email: email)
  # end
  #
  # def self.from_omniauth(auth)
  #   name_split = auth.info.name.split(" ")
  #   user = User.where(email: auth.info.email).first
  #   user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
  #   user
  # end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.image = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails,
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end
  # end
  #
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
  #

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # def self.find_for_facebook(auth_hash)
  #   user = User.where(:email => auth_hash.info["email"]).first
  #
  #   unless user
  #     user = User.create(
  #       username: auth_hash.info["nickname"],
  #       email: auth_hash.info["email"],
  #       password: Devise.friendly_token[0,20])
  #   end
  #
  #   user.provider = auth_hash["provider"]
  #   user.uid = auth_hash["uid"]
  #   user
  # end
end
