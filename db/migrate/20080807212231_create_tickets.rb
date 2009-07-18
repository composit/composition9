class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :project_id
      t.integer :created_by_user_id
      t.text :description
      t.integer :urgency
      t.datetime :closed_date
      t.float :estimated_hours

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
