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

ActiveRecord::Schema.define(version: 20150104161130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alembic_version", id: false, force: true do |t|
    t.string "version_num", limit: 32, null: false
  end

  create_table "binaries", force: true do |t|
    t.integer  "hash",        limit: 8
    t.string   "name",        limit: nil
    t.integer  "total_parts"
    t.datetime "posted"
    t.string   "posted_by",   limit: nil
    t.string   "xref",        limit: nil
    t.string   "group_name",  limit: nil
    t.integer  "regex_id"
  end

  add_index "binaries", ["hash"], name: "ix_binaries_hash", using: :btree
  add_index "binaries", ["name"], name: "ix_binaries_name", using: :btree
  add_index "binaries", ["regex_id"], name: "ix_binaries_regex_id", using: :btree

  create_table "blacklists", force: true do |t|
    t.string  "description", limit: nil
    t.string  "group_name",  limit: nil
    t.string  "field",       limit: nil, default: "subject", null: false
    t.text    "regex"
    t.boolean "status"
  end

  add_index "blacklists", ["group_name"], name: "ix_blacklists_group_name", using: :btree
  add_index "blacklists", ["regex"], name: "blacklists_regex_key", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string  "name",      limit: nil
    t.integer "parent_id"
  end

  add_index "categories", ["parent_id"], name: "ix_categories_parent_id", using: :btree

  create_table "datalogs", force: true do |t|
    t.string "description", limit: nil
    t.text   "data"
  end

  add_index "datalogs", ["description"], name: "ix_datalogs_description", using: :btree

  create_table "episodes", force: true do |t|
    t.integer "tvshow_id"
    t.string  "season",      limit: 10
    t.string  "episode",     limit: 20
    t.string  "series_full", limit: nil
    t.string  "air_date",    limit: 16
    t.string  "year",        limit: 8
  end

  add_index "episodes", ["tvshow_id", "series_full"], name: "episodes_tvshow_id_series_full_key", unique: true, using: :btree
  add_index "episodes", ["tvshow_id"], name: "ix_episodes_tvshow_id", using: :btree

  create_table "files", force: true do |t|
    t.string  "name",       limit: nil
    t.integer "size",       limit: 8
    t.integer "release_id"
  end

  add_index "files", ["release_id"], name: "ix_files_release_id", using: :btree

  create_table "groups", force: true do |t|
    t.boolean "active"
    t.integer "first",  limit: 8
    t.integer "last",   limit: 8
    t.string  "name",   limit: nil
  end

  add_index "groups", ["active"], name: "ix_groups_active", using: :btree

# Could not dump table "metablack" because of following StandardError
#   Unknown type 'enum_metablack_status' for column 'status'

  create_table "misses", force: true do |t|
    t.string  "group_name", limit: nil
    t.integer "message",    limit: 8,   null: false
    t.integer "attempts"
  end

  add_index "misses", ["group_name"], name: "ix_misses_group_name", using: :btree
  add_index "misses", ["message"], name: "ix_misses_message", using: :btree

  create_table "movies", force: true do |t|
    t.string  "name",  limit: nil
    t.string  "genre", limit: nil
    t.integer "year"
  end

  add_index "movies", ["name"], name: "ix_movies_name", using: :btree
  add_index "movies", ["year"], name: "ix_movies_year", using: :btree

  create_table "nfos", force: true do |t|
    t.binary "data"
  end

  create_table "nzbs", force: true do |t|
    t.binary "data"
  end

  create_table "parts", force: true do |t|
    t.integer  "hash",           limit: 8
    t.string   "subject",        limit: nil
    t.integer  "total_segments"
    t.datetime "posted"
    t.string   "posted_by",      limit: nil
    t.string   "xref",           limit: nil
    t.string   "group_name",     limit: nil
    t.integer  "binary_id"
  end

  add_index "parts", ["binary_id"], name: "ix_parts_binary_id", using: :btree
  add_index "parts", ["group_name"], name: "ix_parts_group_name", using: :btree
  add_index "parts", ["hash"], name: "ix_parts_hash", using: :btree
  add_index "parts", ["posted"], name: "ix_parts_posted", using: :btree
  add_index "parts", ["total_segments"], name: "ix_parts_total_segments", using: :btree

  create_table "regexes", force: true do |t|
    t.text    "regex"
    t.string  "description", limit: nil
    t.boolean "status"
    t.integer "ordinal"
    t.string  "group_name",  limit: nil
  end

# Could not dump table "releases" because of following StandardError
#   Unknown type 'enum_passworded' for column 'passworded'

  create_table "segments", force: true do |t|
    t.integer "segment"
    t.integer "size"
    t.string  "message_id", limit: nil
    t.integer "part_id",    limit: 8
  end

  add_index "segments", ["part_id"], name: "ix_segments_part_id", using: :btree
  add_index "segments", ["segment"], name: "ix_segments_segment", using: :btree

  create_table "sfvs", force: true do |t|
    t.binary "data"
  end

  create_table "tvshows", force: true do |t|
    t.string "name",    limit: nil
    t.string "country", limit: 5
  end

  add_index "tvshows", ["name"], name: "ix_tvshows_name", using: :btree

  create_table "users", force: true do |t|
    t.string  "api_key", limit: 32
    t.string  "email",   limit: nil
    t.integer "grabs"
  end

  add_index "users", ["api_key"], name: "users_api_key_key", unique: true, using: :btree
  add_index "users", ["email"], name: "users_email_key", unique: true, using: :btree

end
