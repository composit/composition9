class CreateOfficeHours < ActiveRecord::Migration
  def self.up
    create_table :office_hours do |t|
      t.integer :client_id
      t.integer :user_id
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute
      t.integer :day

      t.timestamps
    end
  end

  def self.down
    drop_table :office_hours
  end
end
