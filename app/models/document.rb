class Document < ActiveRecord::Base
  attr_accessible :name, :file, :trainer_id, :client_ids
  mount_uploader :file, DocumentUploader

  belongs_to :trainer
  has_and_belongs_to_many :clients
end
