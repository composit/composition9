class CreateProjectUsers < ActiveRecord::Migration
  def self.up
    create_table :project_users do |t|
      t.integer :client_id
      t.integer :user_id
      t.datetime :approved_date
      t.boolean :is_worker

      t.timestamps
    end
  end

  def self.down
    drop_table :project_users
  end
end
