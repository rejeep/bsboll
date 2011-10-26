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

ActiveRecord::Schema.define(:version => 20111026170517) do

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holes", :force => true do |t|
    t.integer  "nr"
    t.integer  "hcp"
    t.integer  "par"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hole_id"
    t.integer  "points_for_birdie",      :default => 0, :null => false
    t.integer  "points_for_closest_pin", :default => 0, :null => false
    t.integer  "player_id"
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["reset_password_token"], :name => "index_players_on_reset_password_token", :unique => true

  create_table "scores", :force => true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "hole_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer  "match_id"
    t.integer  "captain_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shots_captain"
    t.integer  "shots_player"
  end

end
