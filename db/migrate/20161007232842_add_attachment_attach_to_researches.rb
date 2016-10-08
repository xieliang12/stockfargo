class AddAttachmentAttachToResearches < ActiveRecord::Migration
  def self.up
    change_table :researches do |t|
      t.attachment :attach
    end
  end

  def self.down
    remove_attachment :researches, :attach
  end
end
