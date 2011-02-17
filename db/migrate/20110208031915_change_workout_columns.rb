class ChangeWorkoutColumns < ActiveRecord::Migration
  def self.up
    add_column :workouts, :supplements, :string
    add_column :workouts, :duration, :integer
  end

  def self.down
    remove_column :workouts, :supplements
    remove_column :workouts, :duration
  end
end
