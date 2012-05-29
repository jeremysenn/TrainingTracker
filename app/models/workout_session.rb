class WorkoutSession < ActiveRecord::Base
  attr_accessible :workout_id, :user_id, :client_id, :notes, :date, :supplements, :duration, :exercise_sessions_attributes, :workout_name

  belongs_to :user
  belongs_to :client
  belongs_to :workout
  has_many :exercise_sessions, :dependent => :destroy

  validates :date, :presence => true
  validates :workout_name, :presence => true

#  validate do |workout_session|
#	  if workout_session.workout.name.blank?
#	    workout_session.errors[:base] << "Workout Name cannot be blank."
#    end
#	end

  accepts_nested_attributes_for :exercise_sessions, :allow_destroy => true
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
#    :reject_if => proc { |attributes| attributes['exercise_name'].blank? }
    
  accepts_nested_attributes_for :client

  #############################
  #     Instance Methods      #
  #############################

  def workout_name()
    workout.name unless workout.blank?
  end

  def workout_name=(wn)
		@workout_name = wn
	end


  ##############################
  #    Class Methods           #
  ##############################

  def self.send_reminder
    workout_sessions = WorkoutSession.find(:all, :conditions => {:reminder_sent => false, :date => (Time.now.utc)..(Time.now.utc + 24.hours)})
    workout_sessions.each do |workout_session|
      if !workout_session.client.blank? and !workout_session.client.trainer.blank?
        SupportMailer.workout_reminder_notification(workout_session).deliver
        workout_session.reminder_sent = true
        workout_session.save
      end
    end
  end


end
