class AddCircumferenceUnitsToBodycomps < ActiveRecord::Migration
  def self.up
    add_column :bodycomps, :circumference_units, :string, :default => "inches"
  end

  def self.down
    remove_column :bodycomps, :circumference_units
  end
end
