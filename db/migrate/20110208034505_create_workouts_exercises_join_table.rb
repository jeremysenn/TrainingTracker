class CreateWorkoutsExercisesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :exercises_workouts, :id => false do |t|
        t.integer :workout_id
        t.integer :exercise_id
      end

  end

  def self.down
    drop_table :exercises_workouts
  end
end
