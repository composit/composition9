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

ActiveRecord::Schema.define(:version => 20091026050849) do

  create_table "alerts", :force => true do |t|
    t.string   "action_statement"
    t.integer  "client_id"
    t.integer  "project_id"
    t.integer  "ticket_id"
    t.integer  "ticket_comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_users", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.boolean  "is_worker"
    t.boolean  "can_view_invoices"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.integer  "priority"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "web_address"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "committed_week_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "billing_rate_dollars"
    t.string   "billing_rate_unit"
    t.boolean  "active"
  end

  create_table "invoice_adjustment_lines", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "description"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "client_id"
    t.date     "invoice_date"
    t.date     "paid_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "office_hours", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.integer  "day_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "pauses", :force => true do |t|
    t.string   "title"
    t.integer  "interval"
    t.integer  "allowed_length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "project_users", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "approved_date"
    t.boolean  "is_worker"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "client_id"
    t.integer  "created_by_user_id"
    t.string   "title"
    t.date     "closed_date"
    t.integer  "billing_rate_dollars"
    t.string   "billing_rate_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.integer  "urgency"
  end

  create_table "ticket_comments", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_times", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "project_id"
    t.integer  "created_by_user_id"
    t.text     "description"
    t.datetime "closed_date"
    t.float    "estimated_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.integer  "worker_id"
  end

  create_table "user_alerts", :force => true do |t|
    t.integer  "alert_id"
    t.integer  "user_id"
    t.datetime "hidden_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pauses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pause_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "phone"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "is_admin"
    t.string   "time_zone",                               :default => "Mountain Time (US & Canada)"
  end

end
