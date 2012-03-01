class AddDurationToWeightSets < ActiveRecord::Migration
  def self.up
    add_column :weight_sets, :duration, :string
  end

  def self.down
    remove_column :weight_sets, :duration
  end
end
