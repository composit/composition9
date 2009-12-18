require 'spec_helper'

describe ProjectUser do
  it "should create a new instance given valid attributes" do
    project_user = Factory.build( :project_user )
    project_user.should be_valid
  end
end
