class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :album_id
      t.binary :image_file_data
      t.string :caption

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
