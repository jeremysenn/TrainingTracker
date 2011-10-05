class AddRestMeasuresToBiosig < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :neck, :float
    add_column :bodycomps, :shoulder, :float
    add_column :bodycomps, :chest, :float
    add_column :bodycomps, :arm, :float
    add_column :bodycomps, :thigh, :float
    add_column :bodycomps, :gastroc, :float
  end

  def self.down
    remove_column :bodycomps, :neck
    remove_column :bodycomps, :shoulder
    remove_column :bodycomps, :chest
    remove_column :bodycomps, :arm
    remove_column :bodycomps, :thigh
    remove_column :bodycomps, :gastroc
  end
end
