# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150806154801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string   "phone_number"
    t.integer  "health_post_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "agents", ["health_post_id"], name: "index_agents_on_health_post_id", using: :btree

  create_table "health_centers", force: :cascade do |t|
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "health_posts", force: :cascade do |t|
    t.string   "phone_number"
    t.integer  "health_center_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "health_posts", ["health_center_id"], name: "index_health_posts_on_health_center_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "body"
    t.string   "to"
    t.string   "from"
    t.string   "date_sent"
    t.string   "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tecnicos", force: :cascade do |t|
    t.string   "phone_number"
    t.integer  "health_post_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tecnicos", ["health_post_id"], name: "index_tecnicos_on_health_post_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.string   "screenname"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
  end

  add_foreign_key "agents", "health_posts"
  add_foreign_key "health_posts", "health_centers"
  add_foreign_key "tecnicos", "health_posts"
end
