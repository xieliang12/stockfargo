class RemoveValueFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :value, :string
  end
end
