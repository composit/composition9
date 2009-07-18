class AddBillingRatesToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :billing_rate_dollars, :integer
    add_column :clients, :billing_rate_unit, :string
  end

  def self.down
    remove_column :clients, :billing_rate_dollars
    remove_column :clients, :billing_rate_unit
  end
end
