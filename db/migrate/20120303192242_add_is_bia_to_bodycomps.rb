class AddIsBiaToBodycomps < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :is_bia, :boolean
  end

  def self.down
    remove_column :bodycomps, :is_bia
  end
end
