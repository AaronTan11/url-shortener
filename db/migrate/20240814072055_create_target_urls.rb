class CreateTargetUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :target_urls do |t|
      t.string :target_url
      t.string :title_tag

      t.timestamps
    end
  end
end
