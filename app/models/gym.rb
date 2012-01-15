class Gym < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  has_many :trainers
  has_many :clients, :through => :trainers

  validates :name, :presence => true
end
