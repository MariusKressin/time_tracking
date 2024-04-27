# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_27_221228) do
  create_table "configs", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "dt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.datetime "begin"
    t.datetime "end"
    t.integer "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_desc"
    t.text "long_desc"
    t.boolean "auto_date"
    t.index ["topic_id"], name: "index_hours_on_topic_id"
  end

  create_table "template_hours", force: :cascade do |t|
    t.integer "hours"
    t.integer "minutes"
    t.integer "topic_id", null: false
    t.integer "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_template_hours_on_template_id"
    t.index ["topic_id"], name: "index_template_hours_on_topic_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate"
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.integer "role"
    t.integer "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "hours", "topics"
  add_foreign_key "template_hours", "templates"
  add_foreign_key "template_hours", "topics"
end
