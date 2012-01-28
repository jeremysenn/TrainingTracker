class AddDetailsToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :details, :string
  end

  def self.down
    remove_column :groups, :details
  end
end
