class CreateInvoiceAdjustmentLines < ActiveRecord::Migration
  def self.up
    create_table :invoice_adjustment_lines do |t|
      t.integer :invoice_id
      t.string :description
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_adjustment_lines
  end
end
