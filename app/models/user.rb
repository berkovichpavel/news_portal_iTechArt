class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable # keeps statistics of the number of entries, takes into account time and IT addresses.
         # :omniauthable # authentication using social networks
end
