class AddInvoiceStuffToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :invoice_span, :integer, :default => 2
    add_column :clients, :invoice_span_units, :string, :default => "weeks"
  end

  def self.down
    remove_column :clients, :invoice_span
    remove_column :clients, :invoice_span_units
  end
end
