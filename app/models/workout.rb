class Workout < ActiveRecord::Base
  attr_accessible :user_id, :description, :name
  belongs_to :user
  has_many :workout_sessions

  validates :name, :presence => true
end
