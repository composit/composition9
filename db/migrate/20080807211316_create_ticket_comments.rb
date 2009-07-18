class CreateTicketComments < ActiveRecord::Migration
  def self.up
    create_table :ticket_comments do |t|
      t.integer :ticket_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_comments
  end
end
