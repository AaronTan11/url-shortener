# frozen_string_literal: true

class CreateAnalytics < ActiveRecord::Migration[7.1]
  def change
    create_table :analytics do |t|
      t.references :short_url, null: false, foreign_key: true
      t.string :ip_address
      t.string :country
      t.string :city
      t.datetime :clicked_at

      t.timestamps
    end
  end
end
