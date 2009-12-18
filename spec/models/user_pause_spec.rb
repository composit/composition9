require 'spec_helper'

describe UserPause do
  it "should create a new instance given valid attributes" do
    user_pause = Factory.build( :user_pause )
    user_pause.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should set the start time to the current time if it is not set" do
    #TODO before_validation_on_create
  end

  it "should set the end time to the current time if it is not set" do
    #TODO before_validation_on_update
  end

  it "should close and reopen the current ticket if the pause time has passed on closing" do
    #TODO after_update
  end

  it "should determine if it is overdue" do
    #TODO overdue?
  end

  it "should return its urgency class" do
    #TODO urgency_class
  end
end
