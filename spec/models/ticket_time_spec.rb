require 'spec_helper'

describe TicketTime do
  it "should create a new instance given valid attributes" do
    ticket_time = Factory.build( :ticket_time )
    ticket_time.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should return uninvoiced ticket times" do
    #TODO uninvoiced
  end

  it "should return ticket times before a date" do
    #TODO before_date
  end

  it "should set the start time to the current time if it is not set" do
    #TODO before_validation_on_create
  end

  it "should determine minutes worked" do
    #TODO minutes_worked
  end

  it "should determine hours worked" do
    #TODO hours_worked
  end

  it "should determine dollars" do
    #TODO dollars
  end

  it "should determine the current week start date" do
    #TODO self.week_start_time
  end

  it "should determine the current week end date" do
    #TODO self.week_end_time
  end

  it "should determine the sum of minutes worked by attributes" do
    #TODO self.sum_minutes_worked
  end
end
