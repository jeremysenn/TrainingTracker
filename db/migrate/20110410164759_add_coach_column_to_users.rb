class AddCoachColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :coach, :boolean, :default => 0
  end

  def self.down
    remove_column :users, :coach
  end
end
