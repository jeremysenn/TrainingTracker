class AddHasFreeSubscriptionToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :has_free_subscription, :boolean, :default => false
  end

  def self.down
    remove_column :users, :has_free_subscription
  end
end
