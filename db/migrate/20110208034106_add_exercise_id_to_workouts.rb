class AddExerciseIdToWorkouts < ActiveRecord::Migration
  def self.up
    add_column :workouts, :exercise_id, :integer
  end

  def self.down
    remove_column :workouts, :exercise_id
  end
end
