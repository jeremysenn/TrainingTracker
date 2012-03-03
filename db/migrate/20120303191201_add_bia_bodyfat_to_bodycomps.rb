class AddBiaBodyfatToBodycomps < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :bia_bodyfat, :float
  end

  def self.down
    remove_column :bodycomps, :bia_bodyfat
  end
end
