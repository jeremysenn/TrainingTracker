class CreateWorkoutDetails < ActiveRecord::Migration
  def self.up
    create_table :workout_details do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :workout_details
  end
end
