Factory.define :ticket_time do |f|
  f.association :ticket
  f.association :user
  f.start_time Time.now
end
