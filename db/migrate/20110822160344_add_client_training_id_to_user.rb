class AddClientTrainingIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :client_training_id, :integer
  end

  def self.down
    remove_column :users, :client_training_id
  end
end
