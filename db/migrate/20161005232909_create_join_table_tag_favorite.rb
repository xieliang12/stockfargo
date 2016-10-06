class CreateJoinTableTagFavorite < ActiveRecord::Migration
  def change
    create_join_table :tags, :favorites do |t|
      # t.index [:tag_id, :favorite_id]
      # t.index [:favorite_id, :tag_id]
    end
  end
end
