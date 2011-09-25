class AddIbsToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :ibs, :boolean
  end

  def self.down
    remove_column :clients, :ibs
  end
end
