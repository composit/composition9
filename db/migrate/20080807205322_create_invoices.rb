class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :client_id
      t.date :invoice_date
      t.date :paid_date

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
