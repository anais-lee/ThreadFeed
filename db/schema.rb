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

ActiveRecord::Schema.define(version: 20161205190653) do

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.text     "description"
    t.string   "main_img_url"
    t.integer  "shop_post_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["shop_post_id", "created_at"], name: "index_items_on_shop_post_id_and_created_at"
    t.index ["shop_post_id"], name: "index_items_on_shop_post_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "shop_posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.index ["shop_id", "created_at"], name: "index_shop_posts_on_shop_id_and_created_at"
    t.index ["shop_id"], name: "index_shop_posts_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_shops_on_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
