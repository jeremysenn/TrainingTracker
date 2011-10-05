class AddWaistHipToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :waist, :float
    add_column :bodycomps, :hip, :float
  end

  def self.down
    remove_column :bodycomps, :waist
    remove_column :bodycomps, :hip
  end
end
