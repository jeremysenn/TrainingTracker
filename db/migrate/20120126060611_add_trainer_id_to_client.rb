class AddTrainerIdToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :trainer_id, :integer
  end

  def self.down
    remove_column :clients, :trainer_id
  end
end
