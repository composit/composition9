class RemovePhoneFromClient < ActiveRecord::Migration
  def self.up
    remove_column :clients, :phone
  end

  def self.down
    add_column :clients, :phone, :string
  end
end
