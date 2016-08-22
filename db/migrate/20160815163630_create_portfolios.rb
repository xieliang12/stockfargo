class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.integer :user_id
      t.integer :holding_id

      t.timestamps null: false
    end
  end
end
