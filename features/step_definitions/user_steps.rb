Given /^the following office_hour records for (.*)$/ do |user_login, table|
  table.hashes.each do |hash|
    Factory( :office_hour, hash.merge( :user_id => User.find_by_login( user_login ).id ) )
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) office_hour$/ do |pos|
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following office_hours:$/ do |expected_office_hours_table|
  expected_office_hours_table.diff!(tableish('table tr', 'td,th'))
end

When /^I follow "([^\"]*)" ([0-9]*) times$/ do |link_name, number_of_clicks|
  number_of_clicks.to_i.times { click_link( link_name ) }
end

When /^I fill the following into the office hours index form:$/ do |table|
  table.hashes.each do |hash|
    hash.select do |name, value|
      select( value, :from => "user_office_hour_attributes_#{hash[:row]}_#{name}" ) unless( name == "row" )
    end
  end
end

Then /^I should see the following office hours in order:$/ do |table|
  table.hashes.each do |hash|
    hash.select do |name, value|
      field_with_id( "user_office_hour_attributes_#{hash["row"]}_#{name}" ).element.search( ".//option[@selected = 'selected']" ).inner_html.should =~ /#{value}/ unless( name == "row" )
    end
  end
end
