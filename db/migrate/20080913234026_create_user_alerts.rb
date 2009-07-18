class CreateUserAlerts < ActiveRecord::Migration
  def self.up
    create_table :user_alerts do |t|
      t.integer :alert_id
      t.integer :user_id
      t.datetime :hidden_time

      t.timestamps
    end
  end

  def self.down
    drop_table :user_alerts
  end
end
