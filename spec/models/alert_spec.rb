require 'spec_helper'

describe Alert do
  it "should create a new instance given valid attributes" do
    alert = Factory.build( :alert )
    alert.should be_valid
  end

  it "should not create a new instance given invalid attributes" do
    #TODO invalid
  end

  it "should duplicate the alert to all client users" do
    #TODO after_create
  end

  it "should not duplicate the alert to the same user twice" do
    #TODO after_create
  end

  it "should duplicate the alert to all admin users" do
    #TODO after_create
  end
end
