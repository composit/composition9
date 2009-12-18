require 'spec_helper'

describe Client do
  it "should create a new instance given valid attributes" do
    client = Factory.build( :client )
    client.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should default the active value to true" do
    #TODO before_create
  end

  it "should determine minutes worked" do
    #TODO minutes_worked
  end

  it "should determine hours worked" do
    #TODO hours_worked
  end

  it "should determine committed week hours" do
    #TODO committed_week_hours
  end

  it "should determine hours left this week" do
    #TODO hours_left_this_week
  end

  it "should return workers" do
    #TODO workers
  end

  it "should return open projects" do
    #TODO open_projects
  end

  it "should return closed projects" do
    #TODO closed_projects
  end

  it "should return open hours" do
    #TODO open_hours
  end

  it "should build a new project" do
    #TODO new_project
  end

  it "should return unbilled ticket times" do
    #TODO unbilled_ticket_times
  end

  it "should return the total unpaid invoice amount" do
    #TODO total_unpaid_invoice_value
  end

  it "should determine the invoice span start" do
    #TODO invoice_span_start
  end

  it "should determine if it is overdue for invoicing" do
    #TODO overdue_for_invoicing?
  end
end
