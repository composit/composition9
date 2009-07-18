class CreateClientUsers < ActiveRecord::Migration
  def self.up
    create_table :client_users do |t|
      t.integer :client_id
      t.integer :user_id
      t.boolean :is_worker
      t.boolean :can_view_invoices

      t.timestamps
    end
  end

  def self.down
    drop_table :client_users
  end
end
