class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id, :address, :country, :email, :phone

  belongs_to :user
  has_many :biosignatures

  validates :first_name, :presence => true


  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id
    end
  end
end
