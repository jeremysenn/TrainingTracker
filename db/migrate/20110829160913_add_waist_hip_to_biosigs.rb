class AddWaistHipToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :biosignatures, :waist, :float
    add_column :biosignatures, :hip, :float
  end

  def self.down
    remove_column :biosignatures, :waist
    remove_column :biosignatures, :hip
  end
end
