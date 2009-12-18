require 'spec_helper'

describe OfficeHour do
  it "should create a new instance given valid attributes" do
    office_hour = Factory.build( :office_hour )
    office_hour.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should return current office hours" do
    #TODO current
  end

  it "should return office hours up to a weekday" do
    #TODO up_to_day
  end

  it "should return the date of the office hour" do
    #TODO date
  end

  it "should determine a time string" do
    #TODO time_string
  end

  it "should determine the length in hours" do
    #TODO length_in_hours
  end
end
