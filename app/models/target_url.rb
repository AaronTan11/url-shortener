class TargetUrl < ApplicationRecord
  belongs_to :user
  has_many :short_urls

  validates :target_url, presence: true, uniqueness: { scope: :user_id }
  validates :title_tag, presence: true
end
