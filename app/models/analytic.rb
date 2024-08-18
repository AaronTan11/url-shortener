class Analytic < ApplicationRecord
  belongs_to :short_url

  validates :ip_address, :clicked_at, presence: true
  validates :country, :city, presence: true, allow_nil: true
end
