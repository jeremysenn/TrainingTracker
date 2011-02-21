class CreateWeightSets < ActiveRecord::Migration
  def self.up
    create_table :weight_sets do |t|
      t.float :weight
      t.integer :reps
      t.integer :exercise_session_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :weight_sets
  end
end
