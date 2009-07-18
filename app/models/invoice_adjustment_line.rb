class InvoiceAdjustmentLine < ActiveRecord::Base
  belongs_to :invoice
end
