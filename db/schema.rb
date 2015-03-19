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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150318094005) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "memberships", force: true do |t|
    t.string   "name"
    t.float    "fee_amount", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "transaction_id"
    t.string   "payer_id"
    t.float    "amount",         limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "rapidfire_answer_groups", force: true do |t|
    t.integer  "question_group_id"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_answer_groups", ["question_group_id"], name: "index_rapidfire_answer_groups_on_question_group_id", using: :btree
  add_index "rapidfire_answer_groups", ["user_id", "user_type"], name: "index_rapidfire_answer_groups_on_user_id_and_user_type", using: :btree

  create_table "rapidfire_answers", force: true do |t|
    t.integer  "answer_group_id"
    t.integer  "question_id"
    t.text     "answer_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_answers", ["answer_group_id"], name: "index_rapidfire_answers_on_answer_group_id", using: :btree
  add_index "rapidfire_answers", ["question_id"], name: "index_rapidfire_answers_on_question_id", using: :btree

  create_table "rapidfire_question_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rapidfire_questions", force: true do |t|
    t.integer  "question_group_id"
    t.string   "type"
    t.string   "question_text"
    t.integer  "position"
    t.text     "answer_options"
    t.text     "validation_rules"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_questions", ["question_group_id"], name: "index_rapidfire_questions_on_question_group_id", using: :btree

  create_table "user_relations", force: true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_spouse_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "clinic"
    t.integer  "user_id",                default: 0
    t.integer  "membership_id"
    t.integer  "payment_status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
