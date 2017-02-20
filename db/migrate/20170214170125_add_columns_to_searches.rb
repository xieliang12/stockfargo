class AddColumnsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :market_cap_gteq, :numeric
    add_column :searches, :market_cap_lteq, :numeric
    add_column :searches, :p_e_ratio_gteq, :numeric
    add_column :searches, :p_e_ratio_lteq, :numeric
    add_column :searches, :peg_ratio_gteq, :numeric
    add_column :searches, :peg_ratio_lteq, :numeric
    add_column :searches, :price_to_sales_ttm_gteq, :numeric
    add_column :searches, :price_to_sales_ttm_lteq, :numeric
    add_column :searches, :price_to_book_mra_gteq, :numeric
    add_column :searches, :price_to_book_mra_lteq, :numeric
    add_column :searches, :earnings_per_share_gteq, :numeric
    add_column :searches, :earnings_per_share_lteq, :numeric
  end
end
