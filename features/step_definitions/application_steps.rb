Given /^I am a signed in (.*) user called (.*)$/ do |role, login|
	is_admin = ( role.include?( "admin" ) ? true : false )
  user = Factory( :user, :login => login, :is_admin => is_admin, :password => "testpass", :password_confirmation => "testpass" )
  visit login_path
  fill_in( 'Login', :with => login )
  fill_in( 'Password', :with => "testpass" )
  click_button( 'Log in' )
end

Given /^the following (.+) records:$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end
