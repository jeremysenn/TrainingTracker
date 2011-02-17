class RemoveWorkoutAndExerciseIds < ActiveRecord::Migration
  def self.up
    remove_column :workouts, :exercise_id
    remove_column :exercises, :workout_id
  end

  def self.down
    add_column :workouts, :exercise_id, :integer
    add_column :exercises, :workout_id, :integer
  end
end
