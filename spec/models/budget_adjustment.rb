require 'spec_helper'

describe BudgetAdjustment do
  it "should create a new instance given valid attributes" do
    budget_adjustment = Factory.build( :budget_adjustment )
    budget_adjustment.should be_valid
  end
end
