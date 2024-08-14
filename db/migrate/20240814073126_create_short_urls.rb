class CreateShortUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :short_urls do |t|
      t.string :path
      t.references :target_url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
