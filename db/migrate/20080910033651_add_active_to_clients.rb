class AddActiveToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :active, :boolean
  end

  def self.down
    remove_column :clients, :active
  end
end
