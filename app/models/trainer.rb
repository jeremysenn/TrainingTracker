class Trainer < ActiveRecord::Base
  attr_accessible :gym_id, :user_id, :email

  belongs_to :gym
  belongs_to :user

  has_many :clients

  validates :email, :presence => true
end
