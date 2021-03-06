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

ActiveRecord::Schema.define(version: 20170127065621) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "voice_id"
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "read_flg",   default: 0
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
  add_index "comments", ["voice_id"], name: "index_comments_on_voice_id"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "voice_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "read_flg",   default: 0
  end

  add_index "favorites", ["user_id", "voice_id"], name: "index_favorites_on_user_id_and_voice_id", unique: true
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"
  add_index "favorites", ["voice_id"], name: "index_favorites_on_voice_id"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "message"
    t.integer  "post_user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "read_flg",     default: 0
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "read_flg",    default: 0
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "location"
    t.text     "profile"
    t.string   "birthday"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "voices", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "file"
    t.integer  "original_id"
  end

  add_index "voices", ["user_id", "created_at"], name: "index_voices_on_user_id_and_created_at"
  add_index "voices", ["user_id"], name: "index_voices_on_user_id"

end
