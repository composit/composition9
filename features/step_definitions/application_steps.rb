Given /^I am a signed in (.*) user named (.*)$/ do |role, login|
	is_admin = ( role.include?( "admin" ) ? true : false )
  user = Factory( :user, :login => login, :is_admin => is_admin, :password => "testpass", :password_confirmation => "testpass" )

	post "/login", :login => login, :password => "testpass"
end

Given /^the following (.+) records:$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end
