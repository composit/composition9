require 'spec_helper'

describe UserAlert do
  it "should create a new instance given valid attributes" do
    user_alert = Factory.build( :user_alert )
    user_alert.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should hide itself" do
    #TODO hide_me=
  end
end
