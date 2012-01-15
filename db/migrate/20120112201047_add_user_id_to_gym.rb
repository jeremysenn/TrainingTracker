class AddUserIdToGym < ActiveRecord::Migration
  def self.up
    add_column :gyms, :user_id, :integer
  end

  def self.down
    remove_column :gyms, :user_id
  end
end
