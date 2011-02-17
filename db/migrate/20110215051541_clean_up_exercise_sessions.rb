class CleanUpExerciseSessions < ActiveRecord::Migration
  def self.up
    rename_column :exercise_sessions, :workout_id, :workout_session_id
  end

  def self.down
    rename_column :exercise_sessions, :workout_session_id, :workout_id
  end
end
