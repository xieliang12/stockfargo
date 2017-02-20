class RenameMraToMrqSearches < ActiveRecord::Migration
  def change
    rename_column :searches, :price_to_book_mra_gteq, :price_to_book_mrq_gteq
    rename_column :searches, :price_to_book_mra_lteq, :price_to_book_mrq_lteq
  end
end
