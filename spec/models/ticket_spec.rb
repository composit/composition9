require 'spec_helper'

describe Ticket do
  it "should create a new instance given valid attributes" do
    ticket = Factory.build( :ticket )
    ticket.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should close itself" do
    #TODO close_me
  end

  it "should set the worker id if it is not already set" do
    #TODO before_validation_on_create
  end

  it "should determine its full description" do
    #TODO full_description
  end

  it "should determine the minutes worked" do
    #TODO minutes_worked
  end

  it "should determine the hours worked" do
    #TODO hours_worked
  end

  it "should determine the open hours" do
    #TODO open_hours
  end

  it "should make a new ticket comment" do
    #TODO new_ticket_comment
  end

  it "should return unbilled ticket times" do
    #TODO unbilled_ticket_times
  end

  it "should determine if it is closed" do
    #TODO closed?
  end
end
