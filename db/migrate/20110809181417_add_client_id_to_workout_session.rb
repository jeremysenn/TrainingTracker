class AddClientIdToWorkoutSession < ActiveRecord::Migration
  def self.up
    add_column :workout_sessions, :client_id, :integer
  end

  def self.down
    remove_column :workout_sessions, :client_id
  end
end
