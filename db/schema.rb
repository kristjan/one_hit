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

ActiveRecord::Schema.define(:version => 20110416232849) do

  create_table "authorizations", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["provider", "uid"], :name => "index_authorizations_on_provider_and_uid", :unique => true
  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "badges", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "type",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "badges", ["type"], :name => "index_badges_on_type"
  add_index "badges", ["user_id"], :name => "index_badges_on_user_id"

  create_table "quips", :force => true do |t|
    t.integer  "site_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quips", ["site_id"], :name => "index_quips_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "url",        :null => false
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["url"], :name => "index_sites_on_url", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "crypted_password"
    t.integer  "facebook_uid",     :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid", :unique => true

  create_table "views", :force => true do |t|
    t.integer  "site_id",                   :null => false
    t.integer  "today",      :default => 0
    t.integer  "this_week",  :default => 0
    t.integer  "all_time",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["all_time"], :name => "index_views_on_all_time"
  add_index "views", ["site_id"], :name => "index_views_on_site_id", :unique => true
  add_index "views", ["this_week"], :name => "index_views_on_this_week"
  add_index "views", ["today"], :name => "index_views_on_today"

end
