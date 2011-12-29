class Order < ActiveRecord::Base
  validates :credit_card_number, :presence => true
end
