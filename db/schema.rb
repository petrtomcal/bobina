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

ActiveRecord::Schema.define(:version => 20100820185441) do

  create_table "attachments", :force => true do |t|
    t.integer  "product_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "kinds", :force => true do |t|
    t.string   "kind"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", :force => true do |t|
    t.string   "name"
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

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
  end

  create_table "products_categories", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_on"
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
