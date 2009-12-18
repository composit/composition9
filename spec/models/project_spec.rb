require 'spec_helper'

describe Project do
  it "should create a new instance given valid attributes" do
    project = Factory.build( :project )
    project.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should close itself" do
    #TODO close_me=/close_me
  end

  it "should create a new ticket if the creating user is not admin" do
    #TODO after_create
  end

  it "should close all its tickets when it is closed" do
    #TODO after_update
  end

  it "should determine the minutes worked" do
    #TODO minutes_worked
  end

  it "should determine the hours worked" do
    #TODO hours_worked
  end

  it "should determine the hourly billing rate" do
    #TODO hourly_billing_rate
  end

  it "should determine the open tickets" do
    #TODO open_tickets
  end

  it "should determine the open hours" do
    #TODO open_hours
  end

  it "should determine the estimated hours" do
    #TODO estimated_hours
  end

  it "should make a new ticket" do
    #TODO new_ticket
  end

  it "should determine the estimated complete date" do
    #TODO estimated_complete_date
  end

  it "should determine unbilled ticket times" do
    #TODO unbilled_ticket_times
  end
end
