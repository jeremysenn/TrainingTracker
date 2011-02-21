class WeightSet < ActiveRecord::Base
  attr_accessible :weight, :reps, :exercise_session_id

  belongs_to :exercise_session
end
