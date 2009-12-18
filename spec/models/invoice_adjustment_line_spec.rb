require 'spec_helper'

describe InvoiceAdjustmentLine do
  it "should create a new instance given valid attributes" do
    invoice_adjustment_line = Factory.build( :invoice_adjustment_line )
    invoice_adjustment_line.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end
end
