require 'spec_helper'

describe OfficeHour do
  it "should create a new instance given valid attributes" do
    office_hour = Factory.build( :office_hour )
    office_hour.should be_valid
  end

  it "should set default date and time attributes" do
    office_hour = Factory( :office_hour, :day_of_week => nil )
    office_hour.day_of_week.should eql( 6 )
    office_hour.start_time.strftime( "%H:%M" ).should eql( "18:30" )
    office_hour.end_time.strftime( "%H:%M" ).should eql( "19:30" )
  end

  it "should return office hours in order chronologically" do
    Factory( :office_hour, :day_of_week => 4, :start_time => "10:00" )
    Factory( :office_hour, :day_of_week => 1, :start_time => "10:00" )
    Factory( :office_hour, :day_of_week => 1, :start_time => "9:55" )
    Factory( :office_hour, :day_of_week => 1, :start_time => "16:55" )
    Factory( :office_hour, :day_of_week => 3, :start_time => "10:00" )
    OfficeHour.chronological.collect { |office_hour| [ office_hour.day_of_week, office_hour.start_time.strftime( "%H:%M" ) ] }.should eql( [ [1,"09:55"], [1,"10:00"], [1,"16:55"], [3,"10:00"], [4,"10:00"] ] )
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
