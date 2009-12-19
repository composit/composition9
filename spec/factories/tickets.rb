Factory.define :ticket do |f|
  f.project { |a| a.association( :project_with_worker ) }
  f.created_by_user { |a| a.association( :user ) }
  f.description "go to the store"
end
