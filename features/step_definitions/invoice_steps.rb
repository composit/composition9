Given /^there is a client named (.*)$/ do |name|
  Factory( :client, :name => name )
end

Given /^Client (.*) has an invoice period of (\d+) (.*)$/ do |client_name, invoice_span, invoice_span_units|
  Client.find_by_name( client_name ).update_attributes( :invoice_span => invoice_span, :invoice_span_units => invoice_span_units )
end

Given /^Client (.*) has an invoice dated (\d+) days ago$/ do |client_name, days_ago|
  client = Client.find_by_name( client_name )
  Factory( :invoice, :client_id => client.id, :invoice_date => days_ago.days.ago )
end
