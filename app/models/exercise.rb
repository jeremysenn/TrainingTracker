class Exercise < ActiveRecord::Base
  attr_accessible :name, :description, :user_id

  belongs_to :user
  has_many :exercise_sessions
end
