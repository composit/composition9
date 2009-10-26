class AddTimeZoneToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string, :default => "Mountain Time (US & Canada)"
  end

  def self.down
    remove_column :users, :time_zone
  end
end
