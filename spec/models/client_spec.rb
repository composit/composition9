require 'spec_helper'

describe Client do
  it "should create a new instance given valid attributes" do
    client = Factory.build( :client )
    client.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

	it "should return clients alphabetical by name" do
		Factory( :client, :name => "lmn" )
		Factory( :client, :name => "xyz" )
		Factory( :client, :name => "abc" )

		Client.alphabetical.collect { |client| client.name }.should eql( [ "abc", "lmn", "xyz"] )
	end

  it "should default the active value to true" do
		Factory( :client ).active.should eql( true )
  end

	describe "with ticket times logged" do
		before( :each ) do
			@client = Factory( :client_with_worker )
			project_one = Factory( :project, :client_id => @client.id )
			project_two = Factory( :project, :client_id => @client.id )
			ticket_one = Factory( :ticket, :project_id => project_one.id )
			ticket_two = Factory( :ticket, :project_id => project_two.id )
			@user = Factory( :user )
			Factory( :ticket_time, :ticket_id => ticket_one.id, :start_time => Time.parse( "2009-12-01 09:00:00" ), :end_time => Time.parse( "2009-12-01 12:30:00" ) )
			Factory( :ticket_time, :ticket_id => ticket_two.id, :start_time => Time.parse( "2009-12-08 10:00:00" ), :end_time => Time.parse( "2009-12-08 13:20:00" ), :user_id => @user.id )
			Factory( :ticket_time, :ticket_id => ticket_two.id, :start_time => Time.parse( "2009-12-15 16:00:00" ), :end_time => Time.parse( "2009-12-15 19:10:00" ), :user_id => @user.id )
		end

		it "should determine total minutes worked" do
			@client.minutes_worked.should eql( 600.0 )
		end

		it "should determine minutes worked by week" do
			@client.minutes_worked( Date.parse( "2009-12-01" ) ).should eql( 210.0 )
		end

		it "should determine minutes worked by user" do
			@client.minutes_worked( nil, @user.id ).should eql( 390.0 )
		end

		it "should determine total hours worked" do
			@client.hours_worked.should eql( 10.0 )
		end

		it "should determine hours worked by week" do
			@client.hours_worked( Date.parse( "2009-12-01" ) ).should eql( 3.5 )
		end

		it "should determine hours worked by user" do
			@client.hours_worked( nil, @user.id ).should eql( 6.5 )
		end
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
