class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.string :address
      t.string :country
      t.string :email
      t.string :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
