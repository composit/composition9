require 'spec_helper'

describe Invoice do
  it "should create a new instance given valid attributes" do
    invoice = Factory.build( :invoice )
    invoice.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should return unpaid invoices" do
    #TODO unpaid
  end

  it "should remove foreign keys for ticket times when deleted" do
    #TODO before_destroy
  end

  it "should determine the invoice number" do
    #TODO invoice_number
  end

  it "should determine the total amount" do
    #TODO total_amount
  end

  it "should add new ticket times" do
    #TODO include_ticket_times=
  end

  it "should determine the included projects" do
    #TODO projects
  end

  it "should return project details" do
    #TODO project_details
  end

  it "should determine the payment status" do
    #TODO payment_status
  end
end
