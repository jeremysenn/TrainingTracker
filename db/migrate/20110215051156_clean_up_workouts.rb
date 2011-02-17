class CleanUpWorkouts < ActiveRecord::Migration
  def self.up
    remove_column :workouts, :date
    remove_column :workouts, :notes
    remove_column :workouts, :supplements
    remove_column :workouts, :duration
    add_column :workouts, :description, :text
  end

  def self.down
    add_column :workouts, :date, :date
    add_column :workouts, :notes, :text
    add_column :workouts, :supplements, :string
    add_column :workouts, :duration, :integer
    remove_column :workouts, :description
  end
end
