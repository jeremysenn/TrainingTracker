class AddReminderSentToWorkoutSession < ActiveRecord::Migration
  def self.up
    add_column :workout_sessions, :reminder_sent, :boolean, :default => false
  end

  def self.down
    remove_column :workout_sessions, :reminder_sent
  end
end
