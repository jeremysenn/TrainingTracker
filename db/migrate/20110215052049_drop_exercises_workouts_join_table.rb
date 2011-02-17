class DropExercisesWorkoutsJoinTable < ActiveRecord::Migration
  def self.up
    drop_table :exercises_workouts
  end

  def self.down
    create_table :exercises_workouts, :id => false do |t|
        t.integer :workout_id
        t.integer :exercise_id
      end
  end
end
