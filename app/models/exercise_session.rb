class ExerciseSession < ActiveRecord::Base
  attr_accessible :exercise_id, :workout_session_id, :rest, :tempo, :notes

  belongs_to :workout_session
  belongs_to :exercise
end
