Factory.define :alert do |f|
  f.action_statement "added a comment"
  f.association :user
end

Factory.define :client_user do |f|
  f.association :client
  f.association :user
end

Factory.define :client do |f|
  f.name "Test Client"
  f.address_line_1 "123 Street Ave."
  f.city "Cityville"
  f.state "CO"
  f.zip "80521"
end

Factory.define :invoice do |f|
  f.association :client
  f.invoice_date Date.today
end

Factory.define :pause do |f|
  f.title "Break"
  f.interval 60
  f.allowed_length 10
  f.association :user
end

Factory.define :project do |f|
  f.association :client
  f.association :created_by_user
  f.title "Good Project"
  f.billing_rate_dollars 20
  f.billing_rate_unit "hour"
  f.urgency 2
end

Factory.define :ticket_comment do |f|
  f.association :ticket
  f.association :user
  f.comment "good job"
end

Factory.define :ticket_time do |f|
  f.association :ticket
  f.association :user
  f.start_time Time.now
end

Factory.define :ticket do |f|
  f.association :project
  f.association :created_by_user
  f.description "go to the store"
end

Factory.define :user_alert do |f|
  f.association :alert
  f.association :user
end

Factory.define :user_pause do |f|
  f.association :user
  f.association :pause
end

Factory.define :user do |f|
  f.sequence(:login) { |n| "userguy#{n}" }
  f.sequence(:email) { |n| "test#{n}@composition9.com" }
  f.phone "2223334444"
  f.password "abc123"
  f.password_confirmation { |u| u.password }
end
