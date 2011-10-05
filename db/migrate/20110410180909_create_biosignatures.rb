class CreateBiosignatures < ActiveRecord::Migration
  def self.up
    create_table :bodycomps do |t|
      t.date :date
      t.integer :client_id
      t.integer :age
      t.integer :height
      t.string :height_units
      t.integer :weight
      t.string :weight_units
      t.float :chin
      t.float :cheek
      t.float :pec
      t.float :tri
      t.float :subscap
      t.float :suprailiac
      t.float :midaxil
      t.float :umbilical
      t.float :knee
      t.float :calf
      t.float :quad
      t.float :ham
      t.timestamps
    end
  end

  def self.down
    drop_table :bodycomps
  end
end
