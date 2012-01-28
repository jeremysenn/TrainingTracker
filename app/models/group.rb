class Group < ActiveRecord::Base
  attr_accessible :name, :details

  has_many :users
end
