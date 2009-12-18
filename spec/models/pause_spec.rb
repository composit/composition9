require 'spec_helper'

describe Pause do
  it "should create a new instance given valid attributes" do
    pause = Factory.build( :pause )
    pause.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should create a new user pause" do
    #TODO new_user_pause
  end

  it "should determine if the pause is ready for another" do
    #TODO is_ready?
  end
end
