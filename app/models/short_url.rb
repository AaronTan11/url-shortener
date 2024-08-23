# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  belongs_to :target_url
  has_many :analytics

  validates :path, presence: true, uniqueness: true, length: { maximum: 6 }
end
