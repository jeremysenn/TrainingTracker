class AddCouponToSubscription < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :coupon, :string
  end

  def self.down
    remove_column :subscriptions, :coupon
  end
end
