class AddUserIdToPauses < ActiveRecord::Migration
  def self.up
    add_column :pauses, :user_id, :integer
  end

  def self.down
    remove_column :pauses, :user_id
  end
end
