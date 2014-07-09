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

ActiveRecord::Schema.define(:version => 20111021084647) do

  create_table "assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.date     "assign_date"
    t.date     "close_date"
    t.string   "status"
    t.string   "link"
    t.integer  "person_id"
    t.string   "ticket_type"
  end

  add_index "assignments", ["assign_date", "status"], :name => "index_assignments_on_assign_date_and_status"
  add_index "assignments", ["person_id"], :name => "index_assignments_on_person_id"
  add_index "assignments", ["title"], :name => "index_assignments_on_title"

  create_table "knowledges", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.date     "create_date"
    t.text     "symptom"
    t.text     "cause"
    t.text     "resolution"
    t.string   "KB_type"
    t.string   "product"
    t.integer  "person_id"
    t.integer  "ticket_id"
  end

  add_index "knowledges", ["person_id"], :name => "index_knowledges_on_person_id"
  add_index "knowledges", ["ticket_id"], :name => "index_knowledges_on_ticket_id"

  create_table "notes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.date     "create_date"
    t.text     "summary"
  end

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "serial_number"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tickets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.date     "create_date"
    t.date     "close_date"
    t.string   "status"
    t.text     "summary"
    t.integer  "assignment_id"
    t.string   "ticket_number"
    t.string   "customer"
    t.string   "email"
  end

  add_index "tickets", ["assignment_id"], :name => "index_tickets_on_assignment_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "person_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["person_id"], :name => "index_users_on_person_id"

end
