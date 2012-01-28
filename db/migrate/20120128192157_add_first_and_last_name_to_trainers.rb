class AddFirstAndLastNameToTrainers < ActiveRecord::Migration
  def self.up
    add_column :trainers, :first_name, :string
    add_column :trainers, :last_name, :string
  end

  def self.down
    remove_column :trainers, :first_name
    remove_column :trainers, :last_name
  end
end
