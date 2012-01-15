class CreateTrainers < ActiveRecord::Migration
  def self.up
    create_table :trainers do |t|
      t.integer :gym_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :trainers
  end
end
