class ChangePlanPriceTypeToDecimal < ActiveRecord::Migration
  def self.up
    change_column :plans, :price, :float
  end

  def self.down
    change_column :plans, :price, :integer
  end
end
