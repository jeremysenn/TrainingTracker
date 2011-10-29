class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id, :address, :country, :email, :phone, :notes, :ibs

  belongs_to :user
  has_many :bodycomps
  has_many :workout_sessions
  has_many :foodlogs

  validates :first_name, :presence => true


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
end
