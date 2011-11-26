class WeightSet < ActiveRecord::Base
  attr_accessible :weight, :reps, :exercise_session_id

  belongs_to :exercise_session

  validates :weight, :numericality => true
  validates :reps, :numericality => { :only_integer => true }

  #############################
  #     Instance Methods      #
  #############################

  def volume
    unless self.weight.blank? or self.reps.blank?
      self.weight * self.reps
    end
  end
end
