class CreateFoodlogs < ActiveRecord::Migration
  def self.up
    create_table :foodlogs do |t|
      t.integer :client_id
      t.text :log
      t.date :date
      t.timestamps
    end
  end

  def self.down
    drop_table :foodlogs
  end
end
