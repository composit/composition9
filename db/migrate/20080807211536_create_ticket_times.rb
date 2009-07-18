class CreateTicketTimes < ActiveRecord::Migration
  def self.up
    create_table :ticket_times do |t|
      t.integer :ticket_id
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :invoice_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_times
  end
end
