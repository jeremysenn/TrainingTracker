class Foodlog < ActiveRecord::Base
  attr_accessible :date, :client_id, :log

  belongs_to :client

  validates :date, :presence => true
  validates :log, :presence => true
end
