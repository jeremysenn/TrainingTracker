class AddClientIdToDocumentsAddDocumentIdToClients < ActiveRecord::Migration
  def self.up
    add_column :documents, :client_id, :integer
    add_column :clients, :document_id, :integer
  end

  def self.down
    remove_column :documents, :client_id
    remove_column :clients, :document_id
  end
end
