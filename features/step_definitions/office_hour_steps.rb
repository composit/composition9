Given /^the following office_hours:$/ do |office_hours|
  OfficeHour.create!(office_hours.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) office_hour$/ do |pos|
  visit office_hours_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following office_hours:$/ do |expected_office_hours_table|
  expected_office_hours_table.diff!(tableish('table tr', 'td,th'))
end
