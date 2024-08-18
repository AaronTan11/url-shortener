class TargetUrl < ApplicationRecord
  has_many :short_urls

  validates :target_url, presence: true, uniqueness: true
  validates :title_tag, presence: true
end
