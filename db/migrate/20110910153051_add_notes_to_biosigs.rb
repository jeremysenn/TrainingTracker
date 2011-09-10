class AddNotesToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :biosignatures, :notes, :text
  end

  def self.down
    remove_column :biosignatures, :notes
  end
end
