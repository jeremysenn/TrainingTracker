class Exercise < ActiveRecord::Base
  attr_accessible :name, :description, :user_id, :videos_attributes

  belongs_to :user
  has_many :exercise_sessions
  has_many :videos, :as => 'owner'

  validates :name, :presence => true

  accepts_nested_attributes_for :videos, :allow_destroy => true, :reject_if => proc { |attributes| attributes['url'].blank? }


  #############################
  #     Instance Methods      #
  #############################

  def highest_weight
    high_weight = 0
    self.exercise_sessions.each do |exercise_session|
      if exercise_session.workout_session.client.blank?
        high_weight = exercise_session.highest_weight if (exercise_session.highest_weight and exercise_session.highest_weight > high_weight)
      end
    end
    return high_weight unless high_weight == 0
  end

  def client_highest_weight(client)
    high_weight = 0
    self.exercise_sessions.each do |exercise_session|
      if exercise_session.workout_session.client == client
        high_weight = exercise_session.highest_weight if (exercise_session.highest_weight and exercise_session.highest_weight > high_weight)
      end
    end
    return high_weight unless high_weight == 0
  end

  def highest_set
    high_set_volume = 0
    self.exercise_sessions.each do |exercise_session|
      if exercise_session.workout_session.client.blank?
        volume = exercise_session.highest_set.weight * exercise_session.highest_set.reps if exercise_session.highest_set
      end
      if (volume and volume > high_set_volume)
        high_set_volume = volume
        @high_set = exercise_session.highest_set
      end
    end
    return @high_set
  end

  def client_highest_set(client)
    high_set_volume = 0
    self.exercise_sessions.each do |exercise_session|
      if exercise_session.workout_session.client == client
        volume = exercise_session.highest_set.weight * exercise_session.highest_set.reps if exercise_session.highest_set
      end
      if (volume and volume > high_set_volume)
        high_set_volume = volume
        @high_set = exercise_session.highest_set
      end
    end
    return @high_set
  end

  ##############################
  #    Class Methods           #
  ##############################


end
