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

ActiveRecord::Schema.define(version: 20170709135109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followed_recent_events", force: :cascade do |t|
    t.string "event_type"
    t.string "login"
    t.string "repo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_followed_recent_events_on_user_id"
  end

  create_table "followed_users", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_followed_users_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "follower_uid"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "login"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "recent_events", force: :cascade do |t|
    t.string "event_type"
    t.string "repo"
    t.datetime "created_at", null: false
    t.bigint "user_id"
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recent_events_on_user_id"
  end

  create_table "starred_repos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_starred_repos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "avatar_url"
  end

  add_foreign_key "followed_recent_events", "users"
  add_foreign_key "followed_users", "users"
  add_foreign_key "followers", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "recent_events", "users"
  add_foreign_key "starred_repos", "users"
end
