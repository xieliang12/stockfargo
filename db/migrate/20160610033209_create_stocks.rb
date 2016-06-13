class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol, null: false
      t.decimal :p_e_ratio, :precision => 18, :scale => 4
      t.decimal :peg_ratio, :precision => 18, :scale => 4
      t.decimal :earnings_per_share, :precision => 18, :scale => 4
      t.decimal :ebitda, :precision => 18, :scale => 4
      t.decimal :eps_estimate_current_year, :precision => 18, :scale => 4
      t.decimal :eps_estimate_next_quarter, :precision => 18, :scale => 4
      t.decimal :fifty_day_moving_average, :precision => 18, :scale => 4
      t.decimal :fifty_two_week_high, :precision => 18, :scale => 4
      t.decimal :fifty_two_week_low, :precision => 18, :scale => 4
      t.decimal :percent_change_from_200_day_moving_average, :precision => 6, :scale => 4
      t.decimal :percent_change_from_50_day_moving_average, :precision => 6, :scale => 4
      t.decimal :shares_owned
      t.decimal :short_ratio, :precision => 18, :scale => 4
      t.decimal :two_hundred_day_moving_average, :precision => 18, :scale => 4
      t.decimal :volume
      t.decimal :market_cap
      t.decimal :price_to_sales_ttm, :precision => 18, :scale => 4
      t.decimal :price_to_book_mrq, :precision => 18, :scale => 4
      t.decimal :roa_ttm, :precision => 18, :scale => 4
      t.decimal :roe_ttm, :precision => 18, :scale => 4
      t.decimal :shares_outstanding
      t.decimal :pcnt_held_by_insiders, :precision => 6, :scale => 4
      t.decimal :pcnt_held_by_institutions, :precision => 6, :scale => 4
      t.decimal :pcnt_short_of_float, :precision => 6, :scale => 4
      t.decimal :operating_cash_flow_ttm
      t.decimal :levered_cash_flow_ttm
      t.decimal :book_value_per_share_mrq, :precision => 18, :scale => 4
      t.string :sector
      t.text :industry
      t.text :company_name
      t.timestamps
    end

    add_index :stocks, :symbol, unique: true
  end
end
