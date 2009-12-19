Factory.define :ticket_comment do |f|
  f.association :ticket
  f.association :user
  f.comment "good job"
end
