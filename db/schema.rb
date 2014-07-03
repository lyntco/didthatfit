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

ActiveRecord::Schema.define(version: 20140703075121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "website"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "type_id"
    t.integer  "brand_id"
    t.string   "size"
    t.string   "fit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "user_id"
  end

  create_table "items_outfits", id: false, force: true do |t|
    t.integer "item_id",   null: false
    t.integer "outfit_id", null: false
  end

  add_index "items_outfits", ["item_id", "outfit_id"], name: "index_items_outfits_on_item_id_and_outfit_id", using: :btree
  add_index "items_outfits", ["outfit_id", "item_id"], name: "index_items_outfits_on_outfit_id_and_item_id", using: :btree

  create_table "outfits", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.decimal  "warmth"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "password_digest"
    t.string   "avatar"
    t.string   "size"
    t.integer  "age"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",        default: false
    t.string   "instagram_id"
  end

end
