class DropWorkoutDetailsTable < ActiveRecord::Migration
  def self.up
    drop_table :workout_details
  end

  def self.down
  end
end
