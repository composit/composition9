Factory.define :project do |f|
  f.association :client
  f.created_by_user { |a| a.association( :user ) }
  f.title "Good Project"
  f.billing_rate_dollars 20
  f.billing_rate_unit "hour"
  f.urgency 2
end

Factory.define( :project_with_worker, :parent => :project ) do |f|
  f.client { |a| a.association( :client_with_worker ) }
end
