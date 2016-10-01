class AddSentimentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sentiment, :string
  end
end
