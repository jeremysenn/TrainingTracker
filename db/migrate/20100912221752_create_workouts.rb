class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.integer :workout_detail_id
      t.integer :user_id
      t.date :date
      t.text :notes
      t.timestamps
    end
  end
  
  def self.down
    drop_table :workouts
  end
end
