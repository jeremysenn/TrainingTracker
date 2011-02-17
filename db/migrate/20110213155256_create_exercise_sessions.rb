class CreateExerciseSessions < ActiveRecord::Migration
  def self.up
    create_table :exercise_sessions do |t|
      t.integer :exercise_id
      t.integer :workout_id
      t.string :rest
      t.string :tempo
      t.text :notes
      t.timestamps
    end
  end
  
  def self.down
    drop_table :exercise_sessions
  end
end
