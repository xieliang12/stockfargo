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

ActiveRecord::Schema.define(version: 20161007232842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",      null: false
    t.integer "favorite_id", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.integer  "stock_id"
    t.integer  "portfolio_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "amount"
    t.string   "position"
    t.datetime "date_purchased"
    t.float    "trade_price"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "text"
    t.integer  "favorite_id"
    t.integer  "author_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "sentiment"
    t.string   "post_type"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["favorite_id"], name: "index_posts_on_favorite_id", using: :btree

  create_table "researches", force: :cascade do |t|
    t.string   "title"
    t.integer  "favorite_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
  end

  add_index "researches", ["favorite_id"], name: "index_researches_on_favorite_id", using: :btree
  add_index "researches", ["user_id"], name: "index_researches_on_user_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol",                                                              null: false
    t.decimal  "p_e_ratio",                                  precision: 18, scale: 4
    t.decimal  "peg_ratio",                                  precision: 18, scale: 4
    t.decimal  "earnings_per_share",                         precision: 18, scale: 4
    t.decimal  "ebitda",                                     precision: 18, scale: 4
    t.decimal  "eps_estimate_current_year",                  precision: 18, scale: 4
    t.decimal  "eps_estimate_next_quarter",                  precision: 18, scale: 4
    t.decimal  "fifty_day_moving_average",                   precision: 18, scale: 4
    t.decimal  "fifty_two_week_high",                        precision: 18, scale: 4
    t.decimal  "fifty_two_week_low",                         precision: 18, scale: 4
    t.decimal  "percent_change_from_200_day_moving_average", precision: 6,  scale: 4
    t.decimal  "percent_change_from_50_day_moving_average",  precision: 6,  scale: 4
    t.decimal  "shares_owned"
    t.decimal  "short_ratio",                                precision: 18, scale: 4
    t.decimal  "two_hundred_day_moving_average",             precision: 18, scale: 4
    t.decimal  "volume"
    t.decimal  "market_cap"
    t.decimal  "price_to_sales_ttm",                         precision: 18, scale: 4
    t.decimal  "price_to_book_mrq",                          precision: 18, scale: 4
    t.decimal  "roa_ttm",                                    precision: 18, scale: 4
    t.decimal  "roe_ttm",                                    precision: 18, scale: 4
    t.decimal  "shares_outstanding"
    t.decimal  "pcnt_held_by_insiders",                      precision: 6,  scale: 4
    t.decimal  "pcnt_held_by_institutions",                  precision: 6,  scale: 4
    t.decimal  "pcnt_short_of_float",                        precision: 6,  scale: 4
    t.decimal  "operating_cash_flow_ttm"
    t.decimal  "levered_cash_flow_ttm"
    t.decimal  "book_value_per_share_mrq",                   precision: 18, scale: 4
    t.string   "sector"
    t.text     "industry"
    t.text     "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stocks", ["symbol"], name: "index_stocks_on_symbol", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "yahoo_conglomerates_daily", id: false, force: :cascade do |t|
    t.string  "symbol",    limit: 6,                          null: false
    t.date    "date"
    t.decimal "open",                precision: 18, scale: 4
    t.decimal "high",                precision: 18, scale: 4
    t.decimal "low",                 precision: 18, scale: 4
    t.decimal "close",               precision: 18, scale: 4
    t.integer "volume",    limit: 8
    t.decimal "adj_close",           precision: 18, scale: 4
  end

  add_index "yahoo_conglomerates_daily", ["symbol", "date"], name: "sector", unique: true, using: :btree

  create_table "yahoo_conglomerates_stat", id: false, force: :cascade do |t|
    t.string  "symbol",                                     limit: 6,                           null: false
    t.decimal "p_e_ratio",                                             precision: 18, scale: 4
    t.decimal "peg_raio",                                              precision: 18, scale: 4
    t.decimal "earnings_per_share",                                    precision: 18, scale: 4
    t.decimal "ebitda",                                                precision: 18, scale: 4
    t.decimal "eps_estimate_current_year",                             precision: 18, scale: 4
    t.decimal "eps_estimate_next_quarter",                             precision: 18, scale: 4
    t.decimal "fifty_day_moving_average",                              precision: 18, scale: 4
    t.decimal "fifty_two_week_high",                                   precision: 18, scale: 4
    t.decimal "fifty_two_week_low",                                    precision: 18, scale: 4
    t.decimal "percent_change_from_200_day_moving_average",            precision: 6,  scale: 4
    t.decimal "percent_change_from_50_day_moving_average",             precision: 6,  scale: 4
    t.decimal "shares_owned"
    t.decimal "short_ratio",                                           precision: 18, scale: 4
    t.decimal "two_hundred_day_moving_average",                        precision: 18, scale: 4
    t.decimal "volume"
    t.decimal "market_cap"
    t.decimal "price_to_sales_ttm",                                    precision: 18, scale: 4
    t.decimal "price_to_book_mrq",                                     precision: 18, scale: 4
    t.decimal "roa_ttm",                                               precision: 18, scale: 4
    t.decimal "roe_ttm",                                               precision: 18, scale: 4
    t.decimal "shares_outstanding"
    t.decimal "pcnt_held_by_insiders",                                 precision: 6,  scale: 4
    t.decimal "pcnt_held_by_institutions",                             precision: 6,  scale: 4
    t.decimal "pcnt_short_of_float",                                   precision: 6,  scale: 4
    t.decimal "operating_cash_flow_ttm"
    t.decimal "levered_cash_flow_ttm"
    t.decimal "book_value_per_share_mrq",                              precision: 18, scale: 4
    t.text    "next_earnings_announcement_date"
    t.string  "sector",                                     limit: 18
    t.text    "industry"
    t.text    "company_name"
  end

  add_foreign_key "posts", "favorites"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "researches", "favorites"
  add_foreign_key "researches", "users"
end
