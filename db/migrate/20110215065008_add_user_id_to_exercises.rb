class AddUserIdToExercises < ActiveRecord::Migration
  def self.up
    add_column :exercises, :user_id, :integer
  end

  def self.down
    remove_column :exercises, :user_id
  end
end
