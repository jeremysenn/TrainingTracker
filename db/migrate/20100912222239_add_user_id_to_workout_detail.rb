class AddUserIdToWorkoutDetail < ActiveRecord::Migration
  def self.up
    add_column :workout_details, :user_id, :integer
  end

  def self.down
    remove_column :workout_details, :user_id
  end
end
