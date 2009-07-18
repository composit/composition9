class AddWorkerToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :worker_id, :integer
  end

  def self.down
    remove_column :tickets, :worker_id
  end
end
