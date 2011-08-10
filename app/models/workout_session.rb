class WorkoutSession < ActiveRecord::Base
  attr_accessible :workout_id, :user_id, :client_id, :notes, :date, :supplements, :duration, :exercise_sessions_attributes, :workout_name

  belongs_to :user
  belongs_to :client
  belongs_to :workout
  has_many :exercise_sessions, :dependent => :destroy

  accepts_nested_attributes_for :exercise_sessions, :allow_destroy => true,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
    :reject_if => proc { |attributes| attributes['exercise_name'].blank? }

  def workout_name()
    workout.name unless workout.blank?
  end

  def workout_name=(wn)
		@workout_name = wn
	end


end
