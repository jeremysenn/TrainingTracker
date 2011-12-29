class Plan < ActiveRecord::Base
  attr_accessible :name, :price, :description

  has_many :subscriptions
end
