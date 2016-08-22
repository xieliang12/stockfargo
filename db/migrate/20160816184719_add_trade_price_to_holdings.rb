class AddTradePriceToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :trade_price, :float
  end
end
