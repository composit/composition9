require 'spec_helper'

describe TicketComment do
  it "should create a new instance given valid attributes" do
    ticket_comment = Factory.build( :ticket_comment )
    ticket_comment.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end
end
