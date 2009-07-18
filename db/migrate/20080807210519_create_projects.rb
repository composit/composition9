class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :client_id
      t.integer :created_by_user_id
      t.string :title
      t.date :closed_date
      t.integer :billing_rate_dollars
      t.string :billing_rate_unit

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
