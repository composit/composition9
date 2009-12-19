Factory.define :pause do |f|
  f.title "Break"
  f.interval 60
  f.allowed_length 10
  f.association :user
end
