# frozen_string_literal: true

class AddUserIdToTargetUrls < ActiveRecord::Migration[7.1]
  def change
    add_reference :target_urls, :user, null: true, foreign_key: true
  end
end
