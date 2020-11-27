class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :items
  has_many :comments
  has_many :reviews

  has_one_attached :photo

  enum role: { admin: 'admin', redactor: 'redactor', correspondent: 'correspondent', user: 'user' }
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable # keeps statistics of the number of entries, takes into account time and IT addresses.
         # :omniauthable # authentication using social networks
end
