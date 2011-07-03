# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110701075905) do

  create_table "attachments", :force => true do |t|
    t.integer  "product_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "categories", :force => true do |t|
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "notifier_users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
    t.integer  "category_id"
    t.text     "weblink"
  end

  create_table "packs_categories", :force => true do |t|
    t.integer  "pack_id"
    t.integer  "category_id"
    t.datetime "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs_products", :force => true do |t|
    t.integer  "pack_id"
    t.integer  "product_id"
    t.datetime "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "sale_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
    t.string   "description"
    t.text     "weblink"
  end

  create_table "products_categories", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.integer  "pack_id"
    t.integer  "paid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "purchased_at"
  end

  create_table "sales_packs", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "pack_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_products", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "product_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.text     "email"
    t.text     "secret"
    t.text     "cert_id"
    t.text     "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "phone"
    t.datetime "last_login"
    t.string   "password_hash"
    t.integer  "lock_version",  :default => 0
    t.integer  "authorization"
    t.integer  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
