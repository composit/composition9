require 'spec_helper'

describe User do
  it "should create a new instance given valid attributes" do
    user = Factory.build( :user )
    user.should be_valid
  end

  it "should return alphabetical users" do
		Factory( :user, :login => "xyz" )
		Factory( :user, :login => "abc" )
		Factory( :user, :login => "lmn" )
		User.alphabetical.collect { |user| user.login }.should eql( [ "abc", "lmn", "xyz" ] )
	end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should update office hours" do
    user = Factory( :user )
    office_hour_one = Factory( :office_hour, :user_id => user.id, :start_time => "12:30" )
    office_hour_two = Factory( :office_hour, :user_id => user.id, :day_of_week => 1 )
    office_hour_three = Factory( :office_hour, :user_id => user.id, :end_time => "12:30" )
    user.office_hour_attributes=( { "1" => { :id => office_hour_two.id, :day_of_week => 3 }, "2" => { :id => office_hour_one.id, :start_time => "01:00" }, "3" => { :id => office_hour_three.id, :end_time => "01:00" } } )
    OfficeHour.find( office_hour_one.id ).start_time.strftime( "%H:%M" ).should eql( "01:00" )
    OfficeHour.find( office_hour_two.id ).day_of_week.should eql( 3 )
    OfficeHour.find( office_hour_three.id ).end_time.strftime( "%H:%M" ).should eql( "01:00" )
  end

  it "should not update office hours of another user" do
    user = Factory( :user )
    office_hour_one = Factory( :office_hour, :day_of_week => 1 )
    user.office_hour_attributes=( { :id => office_hour_one.id, :day_of_week => 3 } )
    OfficeHour.find( office_hour_one.id ).day_of_week.should eql( 1 )
  end

  it "should add new office hours" do
    user = Factory( :user )
    user.update_attributes( :number_of_office_hours_to_add => "3" )
    user.office_hours.length.should eql( 3 )
  end

  it "should return admin users" do
    #TODO admin
  end

  it "should strip non-numeric characters from the phone number" do
    #TODO before_validation
  end

  it "should activate the user in the database" do
    #TODO activate
  end

  it "should determine if it is active" do
    #TODO active?
  end

  it "should authenticate users" do
    #TODO self.authenticate
  end

  it "should encrypt passwords with a salt" do
    #TODO self.encrypt
  end

  it "should encrypt passwords" do
    #TODO encrypt
  end

  it "should determine if it is authenticated" do
    #TODO authenticated?
  end

  it "should use a remember token" do
    #TODO remember_token?
  end

  it "should be remembered" do
    #TODO remember_me
  end

  it "should be remembered for an amount of time" do
    #TODO remember_me_for
  end

  it "should be remembered until a time" do
    #TODO remember_me_until
  end

  it "should be forgotten" do
    #TODO forget_me
  end

  it "should determine if it has recently been activated" do
    #TODO recently_activated?
  end

  it "should determine if it belongs to a client" do
    #TODO belongs_to_client?
  end

  it "should determine if it is an administrator for a client" do
    #TODO is_client_admin?
  end

  it "should determine if it is a worker for a client" do
    #TODO is_worker_for_client?
  end

  it "should return active clients" do
    #TODO active_clients
  end

  it "should find an open ticket time" do
    #TODO open_ticket_time
  end

  it "should find an open user pause" do
    #TODO open_user_pause
  end

  it "should determine hours worked" do
    #TODO hours_worked
  end

  it "should determine the hours left this week" do
    #TODO hours_left_this_week
  end

  it "should determine the speculative hours left this week" do
    #TODO speculative_hours_left_this_week
  end

  it "should determine open hours" do
    #TODO open_hours
  end

  it "should determine dollars earned" do
    #TODO dollars_earned
  end

  it "should make a new ticket time" do
    #TODO new_ticket_time
  end

  it "should determine the next ticket" do
    #TODO next_ticket
  end

  it "should return prioritized client users" do
    #TODO prioritized_client_users
  end

  it "should determine active alerts" do
    #TODO active_alerts
  end

  it "should return active user alerts" do
    #TODO active_user_alerts
  end

  it "should return committed week hours" do
    #TODO committed_week_hours
  end

  it "should determine hours on track" do
    #TODO hours_on_track
  end

  it "should determine speculative hours on track" do
    #TODO speculative_hours_on_track
  end

  it "should determine dollars on track" do
    #TODO dollars_on_track
  end

  it "should determine the percent of hours done this week" do
    #TODO percent_hours_this_week
  end

  it "should determine the percent of dollars earned this week" do
    #TODO percent_dollars_this_week
  end

  it "should determine the dollars remaining this week" do
    #TODO dollars_remaining_this_week
  end

  it "should determine the total percent this week" do
    #TODO total_percent_this_week
  end

  it "should determine budget_track" do
    user = Factory( :user )
    client = Factory( :client )
    client_user = Factory( :client_user, :user_id => user.id, :client_id => client.id, :is_worker => 1 )
    project = Factory( :project, :client_id => client.id, :billing_rate_dollars => 100, :billing_rate_unit => "hour" )
    ticket = Factory( :ticket, :project_id => project.id )
    Factory( :ticket_time, :ticket_id => ticket.id, :user_id => user.id, :start_time => "2010-02-10 01:00:00", :end_time => "2010-02-10 06:00:00" )
    Factory( :ticket_time, :ticket_id => ticket.id, :user_id => user.id, :start_time => "2010-02-12 01:00:00", :end_time => "2010-02-12 06:00:00" )
    Factory( :ticket_time, :ticket_id => ticket.id, :user_id => user.id, :start_time => "2010-02-01 01:00:00", :end_time => "2010-02-01 06:00:00" )
    Factory( :budget_adjustment, :user_id => user.id, :amount => -100, :adjustment_date => "2010-02-02" )
    Factory( :budget_adjustment, :user_id => user.id, :amount => 10000, :adjustment_date => "2010-02-13" )

    user.budget_track( Date.parse( "2010-02-02" ) ).should eql( -6780 ) # ( -1450 * 4 ) + ( -290 * 2 ) + ( -100 ) + 500
    user.budget_track( Date.parse( "2010-02-10" ) ).should eql( -7220 ) # ( -1450 * 5 ) + ( -290 * 3 ) + ( -100 ) + 1000
    user.budget_track( Date.parse( "2010-02-13" ) ).should eql( 2700 ) # ( -1450 * 6 ) + ( -100 + 10000 ) + 1500
  end
end
