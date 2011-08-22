class AddIsClientColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_client, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_client
  end
end
