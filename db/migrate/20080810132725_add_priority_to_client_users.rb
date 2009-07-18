class AddPriorityToClientUsers < ActiveRecord::Migration
  def self.up
    add_column :client_users, :priority, :integer
  end

  def self.down
    remove_column :client_users, :priority
  end
end
