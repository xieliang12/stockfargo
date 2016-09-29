class RenameCommentsToPosts < ActiveRecord::Migration
  def change
    rename_table :comments, :posts
  end
end
