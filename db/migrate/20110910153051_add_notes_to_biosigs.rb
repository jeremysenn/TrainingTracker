class AddNotesToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :notes, :text
  end

  def self.down
    remove_column :bodycomps, :notes
  end
end
