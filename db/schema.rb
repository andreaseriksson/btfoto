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

ActiveRecord::Schema.define(version: 20160810161321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.datetime "start_time"
    t.boolean  "approved",               default: false
    t.boolean  "booked",                 default: false
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "image_nr",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["product_category_id"], name: "index_categorizations_on_product_category_id", using: :btree
  add_index "categorizations", ["product_id"], name: "index_categorizations_on_product_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "password",    limit: 255
    t.string   "first_name",  limit: 255
    t.string   "family_name", limit: 255
    t.string   "address",     limit: 255
    t.string   "zip",         limit: 255
    t.string   "city",        limit: 255
    t.string   "country",     limit: 255
    t.string   "phone",       limit: 255
    t.string   "cellphone",   limit: 255
    t.boolean  "active",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["username"], name: "index_customers_on_username", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "file_name",  limit: 255
    t.string   "file_type",  limit: 255
    t.string   "file_size",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "slug",         limit: 255
    t.text     "preamble"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "published_at"
  end

  add_index "news", ["slug"], name: "index_news_on_slug", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "price",                  precision: 8, scale: 2, default: 0.0
    t.decimal  "vat",                    precision: 8, scale: 2, default: 0.0
    t.decimal  "discount",               precision: 8, scale: 2, default: 0.0
    t.string   "image_nr",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "first_name",     limit: 255
    t.string   "family_name",    limit: 255
    t.string   "address1",       limit: 255
    t.string   "address2",       limit: 255
    t.string   "phone",          limit: 255
    t.string   "email",          limit: 255
    t.string   "city",           limit: 255
    t.string   "zip",            limit: 255
    t.decimal  "shipping_cost",              precision: 8, scale: 2, default: 0.0
    t.boolean  "confirmed"
    t.string   "token",          limit: 255
    t.string   "payment_type",   limit: 255
    t.boolean  "extra_shipment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "printed_at"
    t.integer  "status",                                             default: 0,   null: false
  end

  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "ancestry",         limit: 255
    t.string   "slug",             limit: 255
    t.integer  "position"
    t.string   "title",            limit: 255
    t.text     "content"
    t.string   "menu_title",       limit: 255
    t.string   "meta_title",       limit: 255
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description"
    t.boolean  "active",                       default: true
    t.string   "url",              limit: 255
    t.boolean  "page_redirect",                default: false
    t.date     "start_date",                   default: '2013-06-23'
    t.date     "end_date",                     default: '2016-06-23'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["ancestry"], name: "index_pages_on_ancestry", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "year"
    t.string   "school",              limit: 255
    t.string   "no",                  limit: 255
    t.integer  "rand"
    t.string   "name",                limit: 255
    t.string   "folder",              limit: 255
    t.boolean  "shown"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",               limit: 255
    t.string   "letter",              limit: 255
  end

  add_index "pictures", ["name", "letter"], name: "index_pictures_on_name_and_letter", using: :btree
  add_index "pictures", ["product_category_id"], name: "index_pictures_on_product_category_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["slug"], name: "index_product_categories_on_slug", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "slug",           limit: 255
    t.text     "description"
    t.decimal  "price",                      precision: 8, scale: 2, default: 0.0
    t.decimal  "discount",                   precision: 8, scale: 2, default: 0.0
    t.decimal  "vat",                        precision: 8, scale: 2, default: 0.0
    t.string   "image",          limit: 255
    t.boolean  "allow_discount",                                     default: false
    t.boolean  "freight",                                            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_type"
  end

  add_index "products", ["product_type"], name: "index_products_on_product_type", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
