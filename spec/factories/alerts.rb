Factory.define :alert do |f|
  f.action_statement "added a comment"
  f.association :user
end
