class RemoveNotesFromExerciseSessions < ActiveRecord::Migration
  def self.up
    remove_column :exercise_sessions, :notes
  end

  def self.down
    add_column :exercise_sessions, :notes, :text
  end
end
