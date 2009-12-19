Factory.define :invoice do |f|
  f.association :client
  f.invoice_date Date.today
end
