Factory.define :user do |f|
  f.sequence(:login) { |n| "userguy#{n}" }
  f.sequence(:email) { |n| "test#{n}@composition9.com" }
  f.phone "2223334444"
  f.password "abc123"
  f.password_confirmation { |u| u.password }
end
