require 'spec_helper'

describe ClientUser do
  it "should create a new instance given valid attributes" do
    client_user = Factory.build( :client_user )
    client_user.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should return prioritized client users" do
    #TODO prioritized
  end
end
