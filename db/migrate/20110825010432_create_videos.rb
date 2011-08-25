class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.text :embed_code
      t.integer :owner_id
      t.integer :client_id
      t.string  :url, :null => false
      t.string :owner_type
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
