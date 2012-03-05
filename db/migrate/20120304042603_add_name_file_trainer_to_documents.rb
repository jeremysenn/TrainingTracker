class AddNameFileTrainerToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :name, :string
    add_column :documents, :file, :string
    add_column :documents, :trainer_id, :integer
  end

  def self.down
    remove_column :documents, :trainer_id
    remove_column :documents, :file
    remove_column :documents, :name
  end
end
