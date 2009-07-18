class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :web_address
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.integer :committed_week_hours

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
