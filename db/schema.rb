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

ActiveRecord::Schema.define(version: 2019_01_12_085930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_store_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_type", null: false
    t.binary "metadata"
    t.binary "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
  end

  create_table "event_store_events_in_streams", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "order_lines", force: :cascade do |t|
    t.string "order_uid"
    t.integer "product_id"
    t.string "product_name"
    t.integer "quantity"
  end

  create_table "orders", force: :cascade do |t|
    t.string "uid"
    t.string "number"
    t.string "customer"
    t.string "state"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ui_developer_list_read_models", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.index ["email"], name: "index_ui_developer_list_read_models_on_email"
  end

  create_table "ui_notification_list_read_models", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.text "message"
  end

  create_table "ui_project_aproximate_end_read_models", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.integer "estimation"
    t.jsonb "working_hours", default: {}
    t.datetime "approximate_end"
  end

  create_table "ui_project_details_read_models", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
    t.integer "estimation_in_hours"
    t.jsonb "developers", default: []
    t.datetime "deadline"
  end

  create_table "ui_project_list_read_models", primary_key: "uuid", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name"
  end

end
