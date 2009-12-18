Given /^There is a client named (.*)$/ do |name|
  Factory( :client, :name => name )
end
