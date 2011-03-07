class WorkoutSession < ActiveRecord::Base
  attr_accessible :workout_id, :user_id, :notes, :date, :supplements, :duration, :exercise_sessions_attributes

  belongs_to :user
  belongs_to :workout
  has_many :exercise_sessions, :dependent => :destroy

  accepts_nested_attributes_for :exercise_sessions, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

end
