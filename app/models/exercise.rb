class Exercise < ActiveRecord::Base
  attr_accessible :name, :description, :user_id

  belongs_to :user
  has_many :exercise_sessions

  #############################
  #     Instance Methods      #
  #############################

  def highest_weight
    high_weight = 0
    self.exercise_sessions.each do |exercise_session|
      high_weight = exercise_session.highest_weight if (exercise_session.highest_weight and exercise_session.highest_weight > high_weight)
    end
    return high_weight unless high_weight == 0
  end

  def highest_set
    high_set_volume = 0
    self.exercise_sessions.each do |exercise_session|
      volume = exercise_session.highest_set.weight * exercise_session.highest_set.reps if exercise_session.highest_set
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
