class AddIsTrainerAndIsGymToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_trainer, :boolean
    add_column :users, :is_gym, :boolean
  end

  def self.down
    remove_column :users, :is_trainer
    remove_column :users, :is_gym
  end
end
