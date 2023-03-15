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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_092420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|

    t.bigint "employee_id"
    t.string "tag_no"
    t.string "image_url", null: false
    t.boolean "status", default: false, null: false
    t.string "tag_no", null: false
    t.string "image_url", null: false
    t.boolean "status", default: false, null: false
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_devices_on_employee_id"
  end

  create_table "employee_details", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "phone_number", null: false
    t.string "designation", null: false
    t.date "date_of_birth", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_details_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "emp_id"
    t.string "email", null: false
    t.string "encrypted_password", default: "Prasthana@2023", null: false
    t.string "jti", null: false
    t.string "status", default: "pending", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["jti"], name: "index_employees_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.string "role", default: "employee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_roles_on_employee_id"
  end

  add_foreign_key "devices", "employees"
  add_foreign_key "employee_details", "employees"
  add_foreign_key "roles", "employees"
end
