class AddSetsToExerciseSessions < ActiveRecord::Migration
  def self.up
    add_column :exercise_sessions, :sets, :integer
  end

  def self.down
    remove_column :exercise_sessions, :sets
  end
end
