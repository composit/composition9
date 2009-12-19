Factory.define :client do |f|
  f.name "Test Client"
  f.address_line_1 "123 Street Ave."
  f.city "Cityville"
  f.state "CO"
  f.zip "80521"
end

Factory.define( :client_with_worker, :parent => :client ) do |f|
  f.after_create { |client| Factory( :worker_client_user, :client_id => client.id ) }
end
