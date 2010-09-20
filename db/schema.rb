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

ActiveRecord::Schema.define(:version => 20100920141208) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hrs", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "hr_id",                           :null => false
    t.string   "company_name",                    :null => false
    t.string   "website"
    t.boolean  "called",       :default => false
    t.boolean  "viewed",       :default => false
    t.boolean  "taken",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hrs", ["user_id"], :name => "index_hrs_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_users", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "language_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_details", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.date     "dob"
    t.integer  "age"
    t.boolean  "gender",          :default => true
    t.string   "qualification",                         :null => false
    t.text     "address",                               :null => false
    t.string   "relationship",    :default => "friend"
    t.boolean  "job_status",      :default => false
    t.text     "resume"
    t.boolean  "work_status",     :default => false
    t.text     "lang_experiance"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_details", ["job_status"], :name => "index_member_details_on_job_status"
  add_index "member_details", ["user_id"], :name => "index_member_details_on_user_id"
  add_index "member_details", ["work_status"], :name => "index_member_details_on_work_status"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                :limit => 50,                    :null => false
    t.string   "mobile",              :limit => 15,                    :null => false
    t.string   "login"
    t.string   "email",                                                :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                                    :null => false
    t.string   "single_access_token",                                  :null => false
    t.string   "perishable_token",                                     :null => false
    t.boolean  "active",                            :default => false, :null => false
    t.integer  "login_count",                       :default => 0,     :null => false
    t.integer  "failed_login_count",                :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
