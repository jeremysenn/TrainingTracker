class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id, :address, :country, :email, :phone, :notes, :ibs, :trainer_id, :document_ids

  belongs_to :user
  belongs_to :trainer
  has_many :bodycomps
  has_many :workout_sessions
  has_many :foodlogs
  has_many :videos
  has_and_belongs_to_many :documents

  validates :first_name, :presence => true
  validates :last_name, :presence => true


  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id
    end
  end

  def sex
    unless bodycomps.empty?
      bodycomps.first.sex
    else
      nil
    end
  end

  def age
    unless bodycomps.empty?
      bodycomps.last.age
    else
      nil
    end
  end

  def all_bia_bodycomps?
    non_bia_count = 0
    for bodycomp in bodycomps
      unless bodycomp.is_bia?
        non_bia_count = non_bia_count + 1
      end
    end
    if non_bia_count == 0
      return true
    else
      return false
    end
  end
end
