class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :email, :stripe_card_token
  attr_accessor :stripe_card_token

  belongs_to :plan
  belongs_to :user
  validates :email, :presence => true
  validates :plan_id, :presence => true
  validates :user_id, :presence => true

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:description => email, :plan => plan_id, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
