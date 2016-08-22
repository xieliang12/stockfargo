class AddPositionToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :position, :string
  end
end
