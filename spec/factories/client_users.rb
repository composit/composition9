Factory.define :client_user do |f|
  f.association :client
  f.association :user
end

Factory.define( :worker_client_user, :parent => :client_user ) do |f|
  f.is_worker true
end
