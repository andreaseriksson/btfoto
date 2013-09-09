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

ActiveRecord::Schema.define(version: 20130909181527) do

  create_table "appointments", force: true do |t|
    t.string   "label"
    t.datetime "start_time"
    t.boolean  "approved",   default: false
    t.boolean  "booked",     default: false
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "image_nr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: true do |t|
    t.integer  "product_id"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["product_category_id"], name: "index_categorizations_on_product_category_id"
  add_index "categorizations", ["product_id"], name: "index_categorizations_on_product_id"

  create_table "customers", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "family_name"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
    t.string   "cellphone"
    t.boolean  "active",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["username"], name: "index_customers_on_username"

  create_table "galleries", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "news", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "preamble"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "published_at"
  end

  add_index "news", ["slug"], name: "index_news_on_slug"

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "price",      precision: 8, scale: 2, default: 0.0
    t.decimal  "vat",        precision: 8, scale: 2, default: 0.0
    t.decimal  "discount",   precision: 8, scale: 2, default: 0.0
    t.string   "image_nr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: true do |t|
    t.string   "first_name"
    t.string   "family_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "zip"
    t.decimal  "shipping_cost",  precision: 8, scale: 2, default: 0.0
    t.boolean  "confirmed"
    t.string   "token"
    t.string   "payment_type"
    t.boolean  "extra_shipment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "ancestry"
    t.string   "slug"
    t.integer  "position"
    t.string   "title"
    t.text     "content"
    t.string   "menu_title"
    t.string   "meta_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.boolean  "active",           default: true
    t.string   "url"
    t.boolean  "page_redirect",    default: false
    t.date     "start_date",       default: '2013-06-23'
    t.date     "end_date",         default: '2016-06-23'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["ancestry"], name: "index_pages_on_ancestry"
  add_index "pages", ["slug"], name: "index_pages_on_slug"

  create_table "pictures", force: true do |t|
    t.integer  "year"
    t.string   "school"
    t.string   "no"
    t.integer  "rand"
    t.string   "name"
    t.string   "folder"
    t.boolean  "shown"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "letter"
  end

  add_index "pictures", ["name", "letter"], name: "index_pictures_on_name_and_letter"
  add_index "pictures", ["product_category_id"], name: "index_pictures_on_product_category_id"

  create_table "product_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["slug"], name: "index_product_categories_on_slug"

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.decimal  "price",          precision: 8, scale: 2, default: 0.0
    t.decimal  "discount",       precision: 8, scale: 2, default: 0.0
    t.decimal  "vat",            precision: 8, scale: 2, default: 0.0
    t.string   "image"
    t.boolean  "allow_discount",                         default: false
    t.boolean  "freight",                                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_type"
  end

  add_index "products", ["product_type"], name: "index_products_on_product_type"
  add_index "products", ["slug"], name: "index_products_on_slug"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
