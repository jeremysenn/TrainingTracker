class AddEmailAddressToTrainers < ActiveRecord::Migration
  def self.up
    add_column :trainers, :email, :string
  end

  def self.down
    remove_column :trainers, :email
  end
end
