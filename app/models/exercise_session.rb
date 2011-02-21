class ExerciseSession < ActiveRecord::Base
  attr_accessible :exercise_id, :workout_session_id, :rest, :tempo, :notes, :weight_sets_attributes

  belongs_to :workout_session
  belongs_to :exercise
  has_many :weight_sets

  accepts_nested_attributes_for :weight_sets
end
