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

ActiveRecord::Schema.define(version: 20150410022523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: true do |t|
    t.string   "logo"
    t.string   "client_name"
    t.string   "project_name"
    t.date     "date"
    t.float    "cabinet_cost"
    t.float    "granite_cost"
    t.float    "tax_cost"
    t.float    "total_cost"
    t.text     "conditions"
    t.text     "cabinet_mix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cabinet_id"
    t.integer  "granite_id"
    t.boolean  "cabinet_delivery"
    t.boolean  "cabinet_removal"
    t.boolean  "cabinet_installation"
    t.boolean  "cabinet_tax"
  end

  create_table "cabinets", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "specs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "granites", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
