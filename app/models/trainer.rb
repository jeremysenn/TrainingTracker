class Trainer < ActiveRecord::Base
  attr_accessible :gym_id, :user_id, :email, :first_name, :last_name

  belongs_to :gym
  belongs_to :user

  has_many :clients
  has_many :bodycomps, :through => :clients
  has_many :documents

  validates :email, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    elsif !user.first_name.blank? || !user.last_name.blank?
      "#{user.first_name} #{user.last_name}".strip
    else
      id
    end
  end
end
