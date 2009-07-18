class CreateUserPauses < ActiveRecord::Migration
  def self.up
    create_table :user_pauses do |t|
      t.integer :user_id
      t.integer :pause_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :user_pauses
  end
end
