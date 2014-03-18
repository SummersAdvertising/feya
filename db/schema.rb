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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140317092659) do

  create_table "addressbooks", :force => true do |t|
    t.integer  "member_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "status"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "instruction_id"
    t.integer  "article_id"
    t.text     "description"
    t.string   "status"
    t.integer  "sort"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "cover"
    t.integer  "price"
    t.integer  "sell"
    t.integer  "quota"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.integer  "article_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inquirements", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "description"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "instructions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.integer  "sort"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "cover"
  end

  create_table "members", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "address"
    t.string   "tel"
    t.integer  "discountpoint"
    t.string   "receiveaddress"
  end

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "orderitems", :force => true do |t|
    t.integer  "order_id"
    t.integer  "stock_id"
    t.integer  "amount"
    t.string   "status"
    t.integer  "itemprice"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "itemname"
    t.string   "itemtype"
  end

  create_table "orderlogs", :force => true do |t|
    t.integer  "order_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orderrefunds", :force => true do |t|
    t.integer  "order_id"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "member_id"
    t.integer  "shippingfee"
    t.string   "status"
    t.string   "shippingway"
    t.string   "shippingcode"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "ordernum"
    t.string   "buyername"
    t.string   "buyertel"
    t.string   "invoicetype"
    t.string   "companynum"
    t.string   "receivername"
    t.string   "receiveraddress"
    t.string   "receivertel"
    t.string   "paytype"
    t.date     "paydate"
    t.string   "paytime"
    t.string   "payaccount"
    t.integer  "discountpoint"
    t.integer  "discount"
    t.string   "invoicename"
  end

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.integer  "saleprice"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "cover"
    t.integer  "article_id"
    t.integer  "category_id"
    t.boolean  "delete_flag"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "product_id"
    t.string   "typename"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "testimonies", :force => true do |t|
    t.string   "title"
    t.integer  "article_id"
    t.string   "cover"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "instruction_id"
  end

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.text     "comment"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tracebooks", :force => true do |t|
    t.integer  "member_id"
    t.integer  "stock_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
