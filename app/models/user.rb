class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }

  has_many :target_urls
  has_many :short_urls, through: :target_urls
end
