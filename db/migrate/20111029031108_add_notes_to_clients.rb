class AddNotesToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :notes, :text
  end

  def self.down
    remove_column :clients, :notes
  end
end
