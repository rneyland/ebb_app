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

ActiveRecord::Schema.define(:version => 20121211081003) do

  create_table "advertisements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "board_id"
    t.integer  "height"
    t.integer  "width"
    t.integer  "x_location"
    t.integer  "y_location"
    t.string   "image"
    t.binary   "image_contents"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "advertisements", ["board_id"], :name => "index_advertisements_on_board_id"
  add_index "advertisements", ["user_id"], :name => "index_advertisements_on_user_id"

  create_table "boards", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "height"
    t.integer  "width"
    t.string   "timezone"
    t.integer  "age",        :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "boards", ["user_id"], :name => "index_boards_on_user_id"

  create_table "payment_details", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "payment_details", ["user_id"], :name => "index_payment_details_on_user_id"

  create_table "tiles", :force => true do |t|
    t.integer  "advertisement_id"
    t.integer  "x_location"
    t.integer  "y_location"
    t.decimal  "cost"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "board_id"
  end

  add_index "tiles", ["advertisement_id"], :name => "index_tiles_on_advertisement_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
