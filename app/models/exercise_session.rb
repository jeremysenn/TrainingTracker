class ExerciseSession < ActiveRecord::Base
  attr_accessible :exercise_id, :workout_session_id, :rest, :tempo, :notes, :weight_sets_attributes

  belongs_to :workout_session
  belongs_to :exercise
  has_many :weight_sets, :dependent => :destroy

  accepts_nested_attributes_for :weight_sets, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  #############################
  #     Instance Methods      #
  #############################

  def highest_weight
    high_weight = 0
    self.weight_sets.each do |weight_set|
      high_weight = weight_set.weight if (weight_set.weight and weight_set.weight > high_weight)
    end
    return high_weight unless high_weight == 0
  end

  def highest_set
    high_set_volume = 0
    self.weight_sets.each do |weight_set|
      if (weight_set.volume and weight_set.volume > high_set_volume)
        high_set_volume = weight_set.volume
        @high_set = weight_set
      end
    end
    return @high_set
  end

end
