class AddSexToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :sex, :string, :default => "Female"
  end

  def self.down
    remove_column :bodycomps, :sex
  end
end
