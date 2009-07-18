class AddContactInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :address_line_1
    remove_column :users, :address_line_2
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
  end
end
