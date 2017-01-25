class AddSearchNameToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :search_name, :string
    add_index :searches, :search_name, :unique => true
  end
end
