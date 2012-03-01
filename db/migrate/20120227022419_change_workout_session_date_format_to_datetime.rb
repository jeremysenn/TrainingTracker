class ChangeWorkoutSessionDateFormatToDatetime < ActiveRecord::Migration
  def self.up
    change_column :workout_sessions, :date, :datetime
  end

  def self.down
    change_column :workout_sessions, :date, :date
  end
end
