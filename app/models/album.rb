class Album < ActiveRecord::Base

  attr_accessible :name, :imageable_id, :imageable_type, :created_at

  validates :name, :presence => true
  
  belongs_to :imageable, :polymorphic => true
  has_many :images

end
