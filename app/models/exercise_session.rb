class ExerciseSession < ActiveRecord::Base
  attr_accessible :exercise_id, :workout_session_id, :rest, :tempo, :notes, :weight_sets_attributes, :exercise_name

  belongs_to :workout_session
  belongs_to :exercise
  has_many :weight_sets, :dependent => :destroy

  accepts_nested_attributes_for :weight_sets, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  before_save :find_or_create_exercise
  before_update :find_or_create_exercise


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

  def exercise_name()
    @exercise_name
  end

  def exercise_name=(en)
		@exercise_name = en
	end

  def find_or_create_exercise
    
    self.exercise = Exercise.find_or_create_by_name_and_user_id(:name => exercise_name, :user_id => workout_session.user_id)
  end

end
