class CreateClientsDocumentsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :clients_documents, :id => false do |t|
      t.integer :client_id
      t.integer :document_id
    end
  end

  def self.down
    drop_table :clients_documents
  end
end
