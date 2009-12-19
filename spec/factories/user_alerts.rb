Factory.define :user_alert do |f|
  f.association :alert
  f.association :user
end
