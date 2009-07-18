class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.string :action_statement
      t.integer :client_id
      t.integer :project_id
      t.integer :ticket_id
      t.integer :ticket_comment_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
