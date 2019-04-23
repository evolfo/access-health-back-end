class User < ApplicationRecord
  has_secure_password

  has_many :campaigns
  has_many :donations, through: :campaigns

  validates :first_name, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." }
  validates_length_of :first_name, maximum: 12
end