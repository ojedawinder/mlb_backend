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

ActiveRecord::Schema.define(version: 20160909170607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.integer  "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "code"
    t.string   "gameday"
    t.string   "home_time"
    t.string   "original_date"
    t.string   "day"
    t.integer  "home_team_code"
    t.integer  "away_team_code"
    t.integer  "team_id_win"
    t.integer  "team_id_loss"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "historical_dates", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linescore_details", force: :cascade do |t|
    t.integer  "linescore_id"
    t.integer  "inning"
    t.integer  "r_home"
    t.integer  "r_away"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "linescores", force: :cascade do |t|
    t.integer  "e_home"
    t.integer  "e_away"
    t.integer  "r_home"
    t.integer  "r_away"
    t.integer  "h_home"
    t.integer  "h_away"
    t.integer  "inning"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.integer  "win"
    t.integer  "loss"
    t.integer  "away_win"
    t.integer  "home_win"
    t.integer  "away_loss"
    t.integer  "home_loss"
    t.integer  "division_id"
    t.integer  "venue_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
