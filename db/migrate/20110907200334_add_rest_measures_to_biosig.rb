class AddRestMeasuresToBiosig < ActiveRecord::Migration
  def self.up
    add_column :biosignatures, :neck, :float
    add_column :biosignatures, :shoulder, :float
    add_column :biosignatures, :chest, :float
    add_column :biosignatures, :arm, :float
    add_column :biosignatures, :thigh, :float
    add_column :biosignatures, :gastroc, :float
  end

  def self.down
    remove_column :biosignatures, :neck
    remove_column :biosignatures, :shoulder
    remove_column :biosignatures, :chest
    remove_column :biosignatures, :arm
    remove_column :biosignatures, :thigh
    remove_column :biosignatures, :gastroc
  end
end
