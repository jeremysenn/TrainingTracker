class Gym < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  has_many :trainers
  has_many :clients, :through => :trainers
#  has_many :bodycomps, :through => :clients

  validates :name, :presence => true
end
