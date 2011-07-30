class AddSexToBiosigs < ActiveRecord::Migration
  def self.up
    add_column :biosignatures, :sex, :string, :default => "Female"
  end

  def self.down
    remove_column :biosignatures, :sex
  end
end
