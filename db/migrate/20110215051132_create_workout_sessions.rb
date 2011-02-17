class CreateWorkoutSessions < ActiveRecord::Migration
  def self.up
    create_table :workout_sessions do |t|
      t.integer :workout_id
      t.integer :user_id
      t.text :notes
      t.date :date
      t.string :supplements
      t.integer :duration
      t.timestamps
    end
  end
  
  def self.down
    drop_table :workout_sessions
  end
end
