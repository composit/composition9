class AddIsAdminToClientUsers < ActiveRecord::Migration
  def self.up
    add_column :client_users, :is_admin, :boolean
  end

  def self.down
    remove_column :client_users, :is_admin
  end
end
