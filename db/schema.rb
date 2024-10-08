# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_823_055_622) do
  create_table 'analytics', force: :cascade do |t|
    t.integer 'short_url_id', null: false
    t.string 'ip_address'
    t.string 'country'
    t.string 'city'
    t.datetime 'clicked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['short_url_id'], name: 'index_analytics_on_short_url_id'
  end

  create_table 'short_urls', force: :cascade do |t|
    t.string 'path'
    t.integer 'target_url_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['target_url_id'], name: 'index_short_urls_on_target_url_id'
  end

  create_table 'target_urls', force: :cascade do |t|
    t.string 'target_url'
    t.string 'title_tag'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_target_urls_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'analytics', 'short_urls'
  add_foreign_key 'short_urls', 'target_urls'
  add_foreign_key 'target_urls', 'users'
end
